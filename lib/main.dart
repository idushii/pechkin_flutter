import 'package:flutter/material.dart';
import 'package:pechkin_flutter/screens/home_screen.dart';
import 'package:pechkin_flutter/screens/project_view_screen.dart';
import 'package:pechkin_flutter/screens/projects_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        HomeScreen.route: (context) => const HomeScreen(),
        ProjectsScreen.route: (context) => const ProjectsScreen(),
        ProjectViewScreen.route: (context) => const ProjectViewScreen(),
      }
    );
  }
}

