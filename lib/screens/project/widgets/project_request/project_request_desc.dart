import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProjectRequestDesc extends StatelessWidget {
  final ProjectRequest request;
  final FormGroup form;
  final bool isEdit;

  const ProjectRequestDesc({super.key, required this.request, required this.form, required this.isEdit});

  @override
  Widget build(BuildContext context) {

    if (!isEdit) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: Text("[${request.type.toUpperCase()}] ${request.path}", maxLines: 10, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReactiveForm(
          formGroup: form,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: ReactiveDropdownField(
                  decoration: const InputDecoration(labelText: 'Тип'),
                  formControlName: 'type',
                  items: const [
                    DropdownMenuItem(value: 'get', child: Text('GET')),
                    DropdownMenuItem(value: 'post', child: Text('POST')),
                    DropdownMenuItem(value: 'put', child: Text('PUT')),
                    DropdownMenuItem(value: 'delete', child: Text('DELETE')),
                    DropdownMenuItem(value: 'patch', child: Text('PATCH')),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ReactiveTextField(
                  formControlName: 'path',
                  decoration: const InputDecoration(labelText: 'Путь'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
