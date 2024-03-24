import 'package:pechkin_flutter/index.dart';
import 'package:url_launcher/link.dart';

List<NavigationPaneItem> menuItems(BuildContext context) {
  return [
    PaneItem(
      key: const ValueKey('/'),
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const SizedBox.shrink(),
    ),
    PaneItemSeparator(),
    ...[
      PaneItemHeader(
        header: Row(
          children: [
            const Expanded(child: Text('Проекты')),
            IconButton(
                icon: const Icon(FluentIcons.add),
                onPressed: () {
                  createProject(context);
                }),
          ],
        ),
      ),
      PaneItemSeparator(),
      ...projectListCubit.state.projects.map((e) => PaneItem(
            key: ValueKey('/project/${e.id}'),
            icon: const Icon(FluentIcons.folder),
            title: Text(e.name),
            body: const SizedBox.shrink(),
            onTap: () => context.go('/project/${e.id}'),
          ))
    ],
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
}

List<NavigationPaneItem> menuItemsFooter(BuildContext context) {
  return [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey(ProfileScreen.route),
      icon: const Icon(FluentIcons.profile_search),
      title: const Text('Профиль'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != ProfileScreen.route) {
          context.go(ProfileScreen.route);
        }
      },
    ),
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
