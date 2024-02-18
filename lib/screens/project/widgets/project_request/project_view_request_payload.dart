import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';

class ProjectViewRequestPayload extends StatelessWidget {
  final ProjectRequestPayload payload;
  final bool isLast;

  const ProjectViewRequestPayload({super.key, required this.payload, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
      Expanded(child: Text(payload.name)),
      Expanded(child: Text(payload.description)),
      Expanded(child: Text(payload.type)),
      Expanded(child: Text(payload.isArray.toString())),
    ]);
  }
}
