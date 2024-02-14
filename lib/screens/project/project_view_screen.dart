import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/screens/home_screen.dart';
import 'package:pechkin_flutter/screens/project/widgets/projects_groups_list.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({super.key, required this.id});

  final int id;

  static const route = ":id";
  static const routeName = "/projects/:id";

  @override
  Widget build(BuildContext context) {
    final project = mockProjects.firstWhere((project) => project.id == id);
    final groups = mockProjectGroups.where((element) => element.projectId == id);

    return Scaffold(
        appBar: AppBar(
          title: Text(project.name),
          actions: [
            PopupMenuButton(
                onSelected: (value) {},
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 1,
                      child: Text('Изменить'),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text('Поделиться'),
                    ),
                    const PopupMenuItem(
                      value: 3,
                      child: Text('Копировать'),
                    ),
                    const PopupMenuItem(
                      value: 4,
                      child: Text('Удалить'),
                    )
                  ];
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(project.description),
            Expanded(
                child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return ProjectGroupsList(groupId: groups.elementAt(index).id);
              },
            )),
          ]),
        ));
  }
}
