import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_item.dart';

class ProjectInfo extends StatelessWidget {
  final ProjectItem project;

  const ProjectInfo({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Переменные среды', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        const SelectableText('baseUrl: https://test.ru \ntoken: sdjkfhskdsdffahsdgfkjahsgdfjahsd \nisDev: true'),
        const SizedBox(height: 20),
        const SelectableText('Тут будет инфа, для выбранного маршрута'),
      ],
    );
  }

}