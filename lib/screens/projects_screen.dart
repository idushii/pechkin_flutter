import 'package:flutter/material.dart';
import 'package:pechkin_flutter/shared/project_list.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  static const route = "/projects";

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Проекты"),
      ),
      body: SafeArea(
        child: Row(
          children: [
            const Flexible(
              flex: 1,
              child: ProjectList(),
            ),
            if (w > 1000)
              const Flexible(
                flex: 3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Тут будет инфа, общая для всех проектов.'),
                  Text('Так же тут будет список версий для проекта, если тыкнуть на кнопку "Версии"'),
                  Text('Или обсуждения, если тыкнуть на кнопку "Обсуждения"'),
                ]),
              ),
          ],
        ),
      ),
    );
  }
}
