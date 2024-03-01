import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_view_request_payload_item.dart';

class ProjectViewRequestPayload extends StatelessWidget {
  final List<ProjectRequestPayload> payload;
  final String title;
  final bool isEdit;

  const ProjectViewRequestPayload({super.key, required this.payload, required this.title, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: SelectableText(title, style: Theme.of(context).textTheme.titleMedium)),
            // const Icon(Icons.edit, size: 12),
            SizedBox(width: 10,),
          ]
        ),

        for (var i = 0; i < payload.length; i++)
          ProjectViewRequestPayloadItem(payload: payload[i], isLast: i == payload.length - 1, isEdit: isEdit),
      ],
    );
  }
}
