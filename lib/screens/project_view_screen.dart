import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({super.key});

  static const route = "/project_view/:id";

  @override
  Widget build(BuildContext context) {
    final id = (ModalRoute.of(context)!.settings.arguments ?? 0) as int;
    final project = mockProjects.firstWhere((project) => project.id == id);

    return Scaffold(
        appBar: AppBar(
          title: Text(project.name),
        ),
        body: SafeArea(
          child: Column(children: [
            Text(project.description),
            Text('Тут будет список запросов, а справа - просмотр формы запроса и др.'),
          ]),
        ));
  }
}
