import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/screens/home_screen.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({super.key, required this.id});

  final int id;

  static const route = ":id";
  static const routeName = "/projects/:id";

  @override
  Widget build(BuildContext context) {
    final project = mockProjects.firstWhere((project) => project.id == id);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => context.pop(),
          ),
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
