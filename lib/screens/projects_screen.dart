import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/screens/home_screen.dart';
import 'package:pechkin_flutter/shared/projects_list.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  static const route = "/projects";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Проекты"),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => context.pop(HomeScreen.route),
          ),
        ),
        body: SafeArea(
            child: Column(children: [
          if (mockProjects.isEmpty) Text("Нет проектов"),
          Expanded(
              child: ListView.builder(
                  itemCount: mockProjects.length,
                  itemBuilder: (context, index) {
                    return ProjectsListItem(project: mockProjects[index]);
                  }))
        ])));
  }
}
