import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_view_request_payload_item.dart';

class ProjectViewRequestPayload extends StatelessWidget {
  final List<ProjectRequestPayload> payload;
  final String title;
  final bool isEdit;
  final String defaultType;
  final Function(List<ProjectRequestPayload> payload) onEdit;

  const ProjectViewRequestPayload({super.key, required this.payload, required this.title, required this.isEdit, required this.onEdit, required this.defaultType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(child: SelectableText(title, style: Theme.of(context).textTheme.titleMedium)),
          // const Icon(Icons.edit, size: 12),
          const SizedBox(
            width: 10,
          ),
        ]),
        for (var i = 0; i < payload.length; i++)
          ProjectViewRequestPayloadItem(
            payload: payload[i],
            isLast: false,
            isEdit: isEdit,
            onDelete: () {
              onEdit([...payload.sublist(0, i), ...payload.sublist(i + 1)]);
            },
            onEdit: (item) {
              onEdit([...payload.sublist(0, i), item, ...payload.sublist(i + 1)]);
            },
          ),
        if (isEdit)
          ProjectViewRequestPayloadItem(
            payload: ProjectRequestPayload.empty().copyWith(type: defaultType),
            isLast: true,
            isEdit: true,
            onDelete: () {},
            onEdit: (item) {
              onEdit([...payload, item]);
            },
          )
      ],
    );
  }
}
