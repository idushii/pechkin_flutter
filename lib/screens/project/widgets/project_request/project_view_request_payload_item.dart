import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';

class ProjectViewRequestPayloadItem extends StatelessWidget {
  final ProjectRequestPayload payload;
  final bool isLast;
  final bool isEdit;

  const ProjectViewRequestPayloadItem({super.key, required this.payload, required this.isLast, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    final name = "${payload.name}${(payload.type == ProjectRequestPayloadType.ARRAY || payload.isArray) ? '[]' : ''}";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (payload.path.isNotEmpty)
          Container(
            decoration: const BoxDecoration(border: Border(left: BorderSide(color: Colors.grey))),
            width: 10,
            height: isLast ? 10 : 20,
            margin: EdgeInsets.only(bottom: isLast ? 10 : 0),
          ),
        for (var i = 0; i < payload.path.length; i++) const SizedBox(width: 20, height: 20),
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey), left: BorderSide(color: Colors.grey))),
              width: 10,
              height: 10,
            ),
            Container(
              decoration: isLast ? null : const BoxDecoration(border: Border(left: BorderSide(color: Colors.grey))),
              width: 10,
              height: 10,
            )
          ],
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(name)),
        if (payload.type != ProjectRequestPayloadType.ARRAY && payload.type != ProjectRequestPayloadType.OBJECT) ...[
          Expanded(child: Text(payload.description, maxLines: 1, overflow: TextOverflow.ellipsis)),
          Expanded(child: Text(payload.type)),
        ],
      ],
    );
  }
}