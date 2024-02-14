import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/screens/home_screen.dart';
import 'package:pechkin_flutter/screens/project_view_screen.dart';
import 'package:pechkin_flutter/screens/projects_screen.dart';
import 'package:pechkin_flutter/shared/menu.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  routes: [
    ShellRoute(
        navigatorKey: _rootNavigatorKey,
        builder: (context, state, child) {
          return Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                  const Menu(),
                  Expanded(child: child),
                ],
              ),
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const ProjectsScreen(),
          ),
          GoRoute(
            path: ProjectsScreen.route,
            name: ProjectsScreen.route,
            builder: (context, state) => const ProjectsScreen(),
            routes: [
              GoRoute(
                path: ProjectViewScreen.route,
                name: ProjectViewScreen.routeName,
                builder: (context, state) => ProjectViewScreen(id: int.parse(state.pathParameters['id'] ?? '0')),
              ),
            ]
          ),
        ]),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
