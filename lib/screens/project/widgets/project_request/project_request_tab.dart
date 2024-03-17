import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';

class ProjectRequestTab extends StatelessWidget {
  final Function(int index) onSelect;
  final ProjectRequest request;

  const ProjectRequestTab({super.key, required this.onSelect, required this.request});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          ),
          onPressed: () {},
          child: Text('Структура'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Пример 1'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Выполнить'),
        ),
      ],
    );
  }
}
