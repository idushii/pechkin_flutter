import 'package:flutter/cupertino.dart';
import 'package:pechkin_flutter/shared/projects_list_item.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (mockProjects.isEmpty) const Text("Нет проектов"),
      Expanded(
        child: ListView.builder(
            itemCount: mockProjects.length,
            itemBuilder: (context, index) {
              return ProjectsListItem(project: mockProjects[index]);
            }),
      )
    ]);
  }
}
