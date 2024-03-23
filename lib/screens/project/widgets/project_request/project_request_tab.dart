import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/styles/styles.dart';

class ProjectRequestTab extends StatelessWidget {
  final Function(int index) onSelect;
  final ProjectRequest request;

  const ProjectRequestTab({super.key, required this.onSelect, required this.request});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: Styles.btnTab,
          onPressed: () {},
          child: Text('Структура'),
        ),
        for (int i = 0; i < request.samples.length; i++)
          TextButton(
            style: Styles.btnTab,
            onPressed: () {},
            child: Text(request.samples[i].title),
          ),
        TextButton(
          style: Styles.btnTab2,
          onPressed: () {},
          child: Text('Выполнить'),
        ),
      ],
    );
  }
}
