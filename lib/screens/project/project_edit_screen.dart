import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/models/project_item.dart';
import 'package:pechkin_flutter/state/mocks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProjectEditScreen extends StatefulWidget {
  ProjectEditScreen({super.key, required this.id});

  final int id;

  static const route = "edit";
  static const routeName = "project_edit";

  @override
  State<ProjectEditScreen> createState() => _ProjectEditScreenState();
}

class _ProjectEditScreenState extends State<ProjectEditScreen> {
  ProjectItem project = ProjectItem.empty();

  final form = FormGroup({
    'name': FormControl<String>(),
    'description': FormControl<String>(),
  });

  @override
  void initState() {
    project = mockProjects.firstWhere((project) => project.id == widget.id);
    form.value = {
      'name': project.name,
      'description': project.description,
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Редактирование проекта ${project.name}"),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 1) {

                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(value: 1, child: Text('Удалить')),
                ];
              }
            )
          ]
        ),
        body: Center(
          child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(8.0),
              child: ReactiveForm(
                formGroup: form,
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  // label
                  ReactiveTextField<String>(formControlName: 'name', decoration: const InputDecoration(labelText: 'Название')),
                  ReactiveTextField<String>(formControlName: 'description', minLines: 3, maxLines: 100, decoration: const InputDecoration(labelText: 'Описание')),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (form.valid) {
                        context.pop();
                      }
                    },
                    child: const Text('Сохранить'),
                  ),
                ]),
              )),
        ));
  }
}
