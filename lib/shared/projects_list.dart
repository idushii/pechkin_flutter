import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              Navigator.of(context).pushNamed(ProjectViewScreen.route, arguments: project.id);
            }),
        ListTile(
            title: Text('Обсуждения'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed(ProjectViewScreen.route, arguments: project.id);
            }),
        SizedBox(height: 30),
      ],
    );
  }
}
