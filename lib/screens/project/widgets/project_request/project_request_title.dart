import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProjectRequestTitle extends StatelessWidget {
  final ProjectRequest request;
  final FormGroup form;
  final bool isEdit;
  final Function onEdit;

  const ProjectRequestTitle({super.key, required this.request, required this.form, required this.isEdit, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    if (!isEdit) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text( request.name, style: Theme.of(context).textTheme.titleLarge)),
              IconButton(
                onPressed: () => onEdit(),
                icon: isEdit ? const Icon(Icons.check) : const Icon(Icons.edit, size: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(request.description, maxLines: 10, overflow: TextOverflow.ellipsis),
        ],
      );
    };

    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
                Expanded(
                    child: ReactiveTextField(
                        formControlName: 'name',
                        decoration: const InputDecoration(labelText: 'Наименование'),
                        onChanged: (value) {
                          // TODO
                        })),
              IconButton(
                onPressed: () => onEdit(),
                icon: isEdit ? const Icon(Icons.check) : const Icon(Icons.edit, size: 12),
              )
            ],
          ),
          if (!isEdit) Text(request.description),
          if (isEdit)
            ReactiveTextField(
                formControlName: 'description',
                minLines: 1,
                maxLines: 10,
                decoration: const InputDecoration(labelText: 'Описание'),
                onChanged: (value) {
                  // TODO
                })
        ],
      ),
    );
  }
}
