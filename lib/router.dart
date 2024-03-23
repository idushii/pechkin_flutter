import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/MyHomePage.dart';
import 'package:pechkin_flutter/screens/index.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(navigatorKey: rootNavigatorKey, routes: [
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) {
      return MyHomePage(
        shellContext: _shellNavigatorKey.currentContext,
        child: child,
      );
    },
    routes: [
      /// Home
      GoRoute(
        path: '/',
        builder: (context, state) => const ProjectsScreen(),
      ),
      GoRoute(path: ProjectsScreen.route, name: ProjectsScreen.route, builder: (context, state) => const ProjectsScreen(), routes: [
        GoRoute(
          path: ProjectViewScreen.route,
          name: ProjectViewScreen.routeName,
          builder: (context, state) => ProjectViewScreen(id: int.parse(state.pathParameters['id'] ?? '0')),
          routes: [
            GoRoute(
              path: ProjectEditScreen.route,
              name: ProjectEditScreen.routeName,
              builder: (context, state) => ProjectEditScreen(id: int.parse(state.pathParameters['id'] ?? '0')),
            ),
            GoRoute(
              path: ProjectRequestScreen.route,
              name: ProjectRequestScreen.routeName,
              builder: (context, state) => ProjectRequestScreen(
                projectId: int.parse(state.pathParameters['id'] ?? '0'),
                requestId: int.parse(state.pathParameters['requestId'] ?? '0'),
              ),
            ),
          ],
        ),
      ]),
    ],
  ),
]);
