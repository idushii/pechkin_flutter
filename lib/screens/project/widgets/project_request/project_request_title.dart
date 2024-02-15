import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';

class ProjectRequestTitle extends StatefulWidget {
  final ProjectRequest request;

  const ProjectRequestTitle({super.key, required this.request});

  @override
  State<ProjectRequestTitle> createState() => _ProjectRequestTitleState();
}

class _ProjectRequestTitleState extends State<ProjectRequestTitle> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (!isEdit)
            Expanded(child: Text(widget.request.name, style: Theme.of(context).textTheme.titleLarge),),
            if (isEdit)
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Наименование'),
                  autofocus: true,
                  controller: TextEditingController(text: widget.request.name),
                  onChanged: (value) {
                    // TODO
                  }
                )
              ),
            IconButton(
              onPressed: () {
                setState(() => isEdit = !isEdit);
              },
              icon: isEdit ? const Icon(Icons.check) : const Icon(Icons.edit, size: 12),
            )
          ],
        ),
        if (!isEdit)
        Text(widget.request.description),
        if (isEdit)
          TextFormField(
            decoration: const InputDecoration(labelText: 'Описание'),
            controller: TextEditingController(text: widget.request.description),
            onChanged: (value) {
              // TODO
            }
          )
      ],
    );
  }
}