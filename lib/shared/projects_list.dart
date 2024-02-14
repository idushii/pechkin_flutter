import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/models/project_item.dart';
import 'package:pechkin_flutter/screens/project_view_screen.dart';

class ProjectsListItem extends StatelessWidget {
  final ProjectItem project;

  ProjectsListItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(project.name, style: Theme.of(context).textTheme.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(project.description),
        ),
        ListTile(
            title: Text('Запросы'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              context.goNamed(ProjectViewScreen.routeName, pathParameters: {'id': project.id.toString()});
            }),
        ListTile(
            title: Text('Обсуждения'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              context.goNamed(ProjectViewScreen.routeName, pathParameters: {'id': project.id.toString()});
            }),
        SizedBox(height: 30),
      ],
    );
  }
}
