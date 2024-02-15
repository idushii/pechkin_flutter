import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_request_title.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_view_request_payload.dart';
import 'package:pechkin_flutter/state/mocks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProjectViewRequest extends StatelessWidget {
  final int id;

  const ProjectViewRequest({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final request = mockProjectRequests.firstWhere((element) => element.id == id, orElse: () => ProjectRequest.empty());

    if (request.id == 0) {
      return const Center(child: Text('Запрос не найден'));
    }

    final form = FormGroup({
      'type': FormControl<String>(value: request.type),
      'path': FormControl<String>(value: request.path),
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ProjectRequestTitle(request: request),
        SizedBox(height: 10),
        Container(
          child: ReactiveForm(
            formGroup: form,
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: ReactiveDropdownField(
                    decoration: const InputDecoration(labelText: 'Тип'),
                    formControlName: 'type',
                    items: [
                      DropdownMenuItem(value: 'get', child: Text('GET')),
                      DropdownMenuItem(value: 'post', child: Text('POST')),
                      DropdownMenuItem(value: 'put', child: Text('PUT')),
                      DropdownMenuItem(value: 'delete', child: Text('DELETE')),
                      DropdownMenuItem(value: 'patch', child: Text('PATCH')),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ReactiveTextField(
                    formControlName: 'path',
                    decoration: const InputDecoration(labelText: 'Путь'),
                    controller: TextEditingController(text: request.path),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Text('Данные для отправки', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 10),
        for (var item in request.payload)
          ProjectViewRequestPayload(payload: item),
        SizedBox(height: 10),
        Text('Ответ', style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 10),
        for (var item in request.response)
          ProjectViewRequestPayload(payload: item),
      ],
    );
  }
}
