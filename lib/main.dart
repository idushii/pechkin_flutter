import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/screens/home_screen.dart';
import 'package:pechkin_flutter/screens/project_view_screen.dart';
import 'package:pechkin_flutter/screens/projects_screen.dart';

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
            body: Row(
              children: [
                Container(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("Меню", style: TextStyle(fontSize: 20))
                      ),
                      ListTile(
                          title: Text("Проекты"),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            context.goNamed(ProjectsScreen.route);
                          }),
                      ListTile(
                          title: Row(children: [
                            Text("Уведомления"),
                            Container(
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                alignment: Alignment.center,
                                height: 20,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text("10", style: TextStyle(color: Colors.white, fontSize: 10)),
                                ),
                                margin: EdgeInsets.only(left: 10))
                          ]),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            context.goNamed(ProjectsScreen.route);
                          }),
                      ListTile(
                          title: Text("Обсуждения"),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            context.goNamed(ProjectsScreen.route);
                          }),
                      ListTile(
                          title: Text("Команда"),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            context.goNamed(ProjectsScreen.route);
                          }),
                    ]
                  ),
                ),
                Expanded(child: child),
              ],
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
