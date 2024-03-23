import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/main.dart';
import 'package:pechkin_flutter/router.dart';
import 'package:pechkin_flutter/state/index.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:window_manager/window_manager.dart';

import 'theme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.child,
    required this.shellContext,
  });

  final Widget child;
  final BuildContext? shellContext;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool value = false;

  // int index = 0;

  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  late final List<NavigationPaneItem> originalItems = [
    PaneItemHeader(header: const Text('Проекты')),
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/'),
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: Container(
        child: Text('111'),
      ),
    ),
    // PaneItemHeader(header: const Text('Inputs')),
    PaneItem(
      key: const ValueKey('/cubits/cubits'),
      icon: const Icon(FluentIcons.button_control),
      title: const Text('Состояние приложения'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/inputs/buttons'),
      icon: const Icon(FluentIcons.button_control),
      title: const Text('Кеш'),
      body: const SizedBox.shrink(),
    ),
    PaneItem(
      key: const ValueKey('/socket/logs'),
      icon: const Icon(FluentIcons.button_control),
      title: const Text('Логи socket сервера'),
      body: const SizedBox.shrink(),
    ),
  ].map<NavigationPaneItem>((e) {
    PaneItem buildPaneItem(PaneItem item) {
      return PaneItem(
        key: item.key,
        icon: item.icon,
        title: item.title,
        body: item.body,
        onTap: () {
          final path = (item.key as ValueKey).value;
          if (GoRouterState.of(context).uri.toString() != path) {
            context.go(path);
          }
          item.onTap?.call();
        },
      );
    }

    if (e is PaneItemExpander) {
      return PaneItemExpander(
        key: e.key,
        icon: e.icon,
        title: e.title,
        body: e.body,
        items: e.items.map((item) {
          if (item is PaneItem) return buildPaneItem(item);
          return item;
        }).toList(),
      );
    }
    if (e is PaneItem) return buildPaneItem(e);
    return e;
  }).toList();
  late final List<NavigationPaneItem> footerItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/settings'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Настройки'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != '/settings') {
          context.go('/settings');
        }
      },
    ),
    _LinkPaneItemAction(
      icon: const Icon(FluentIcons.open_source),
      title: const Text('Source code'),
      link: 'https://github.com/bdlukaa/fluent_ui',
      body: const SizedBox.shrink(),
    ),
  ];

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int indexOriginal =
    originalItems.where((item) => item.key != null).toList().indexWhere((item) => item.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return originalItems.where((element) => element.key != null).toList().length + indexFooter;
    } else {
      return indexOriginal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = FluentLocalizations.of(context);

    final appTheme = context.watch<AppTheme>();
    final theme = FluentTheme.of(context);
    if (widget.shellContext != null) {
      if (router.canPop() == false) {
        setState(() {});
      }
    }
    return BlocProvider(
        create: (ctx) => authCubit,
        child: NavigationView(
          key: viewKey,
          appBar: NavigationAppBar(
            automaticallyImplyLeading: false,
            leading: () {
              final enabled = widget.shellContext != null && router.canPop();

              final onPressed = enabled
                  ? () {
                if (router.canPop()) {
                  context.pop();
                  setState(() {});
                }
              }
                  : null;
              return NavigationPaneTheme(
                data: NavigationPaneTheme.of(context).merge(NavigationPaneThemeData(
                  unselectedIconColor: ButtonState.resolveWith((states) {
                    if (states.isDisabled) {
                      return ButtonThemeData.buttonColor(context, states);
                    }
                    return ButtonThemeData.uncheckedInputColor(
                      FluentTheme.of(context),
                      states,
                    ).basedOnLuminance();
                  }),
                )),
                child: Builder(
                  builder: (context) => PaneItem(
                    icon: const Center(child: Icon(FluentIcons.back, size: 12.0)),
                    title: Text(localizations.backButtonTooltip),
                    body: const SizedBox.shrink(),
                    enabled: enabled,
                  ).build(
                    context,
                    false,
                    onPressed,
                    displayMode: PaneDisplayMode.compact,
                  ),
                ),
              );
            }(),
            title: () {
              if (kIsWeb) {
                return const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(appTitle),
                );
              }
              return const DragToMoveArea(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(appTitle),
                ),
              );
            }(),
            actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: ToggleSwitch(
                    content: const Text('Dark Mode'),
                    checked: FluentTheme.of(context).brightness.isDark,
                    onChanged: (v) {
                      if (v) {
                        appTheme.mode = ThemeMode.dark;
                      } else {
                        appTheme.mode = ThemeMode.light;
                      }
                    },
                  ),
                ),
              ),
              if (!kIsWeb) const WindowButtons(),
            ]),
          ),
          paneBodyBuilder: (item, child) {
            final name = item?.key is ValueKey ? (item!.key as ValueKey).value : null;
            return FocusTraversalGroup(
              key: ValueKey('body$name'),
              child: widget.child,
            );
          },
          pane: NavigationPane(
            selected: _calculateSelectedIndex(context),
            header: SizedBox(
              height: kOneLineTileHeight,
              child: ShaderMask(
                shaderCallback: (rect) {
                  final color = appTheme.color.defaultBrushFor(
                    theme.brightness,
                  );
                  return LinearGradient(
                    colors: [
                      color,
                      color,
                    ],
                  ).createShader(rect);
                },
                child: SizedBox(),
              ),
            ),
            displayMode: appTheme.displayMode,
            indicator: () {
              switch (appTheme.indicator) {
                case NavigationIndicators.end:
                  return const EndNavigationIndicator();
                case NavigationIndicators.sticky:
                default:
                  return const StickyNavigationIndicator();
              }
            }(),
            items: originalItems,
            footerItems: footerItems,
          ),
          onOpenSearch: searchFocusNode.requestFocus,
        ));
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required super.icon,
    required this.link,
    required super.body,
    super.title,
  });

  final String link;

  @override
  Widget build(
      BuildContext context,
      bool selected,
      VoidCallback? onPressed, {
        PaneDisplayMode? displayMode,
        bool showTextOnTop = true,
        bool? autofocus,
        int? itemIndex,
      }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => Semantics(
        link: true,
        child: super.build(
          context,
          selected,
          followLink,
          displayMode: displayMode,
          showTextOnTop: showTextOnTop,
          itemIndex: itemIndex,
          autofocus: autofocus,
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
