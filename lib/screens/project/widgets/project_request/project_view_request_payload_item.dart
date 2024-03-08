import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/shared/copied_text.dart';

class ProjectViewRequestPayloadItem extends StatelessWidget {
  final ProjectRequestPayload payload;
  final bool isLast;
  final bool isEdit;

  const ProjectViewRequestPayloadItem({super.key, required this.payload, required this.isLast, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    final name = "${payload.name}${(payload.type == ProjectRequestPayloadType.ARRAY || payload.isArray) ? '[]' : ''}";

    final textFieldStyle = InputDecoration(
      contentPadding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          : const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      isDense: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.zero,
      ),
    );

    double size = isEdit ? 20 : 10;
    if (isEdit) {
      if (MediaQuery.of(context).size.width > 600) {
        size = 13;
      } else {
        size = 10;
      }
    }

    return Form(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (payload.path.isNotEmpty)
            Container(
              decoration: const BoxDecoration(border: Border(left: BorderSide(color: Colors.grey))),
              width: size,
              height: isLast ? size : size * 2,
              margin: EdgeInsets.only(bottom: isLast ? size : 0),
            ),
          for (var i = 0; i < payload.path.length; i++) SizedBox(width: size * 2, height: size * 2),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey), left: BorderSide(color: Colors.grey))),
                width: size,
                height: size,
              ),
              Container(
                decoration: isLast ? null : const BoxDecoration(border: Border(left: BorderSide(color: Colors.grey))),
                width: size,
                height: size,
              )
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: isEdit ? TextFormField(controller: TextEditingController(text: name), decoration: textFieldStyle) : CopiedText(name, minWidth: 700),
          ),
          if (payload.type != ProjectRequestPayloadType.ARRAY && payload.type != ProjectRequestPayloadType.OBJECT) ...[
            Container(
                width: 130,
                child: isEdit
                    ? DropdownButtonFormField<String>(
                        value: payload.type,
                        items: [for (var v in ProjectRequestPayloadType.values) DropdownMenuItem(value: v, child: Text(v))],
                        decoration: textFieldStyle,
                        onChanged: (value) {
                          // TODO
                        })
                    : CopiedText(payload.type)),
            Expanded(
                flex: 3,
                child: isEdit
                    ? TextFormField(controller: TextEditingController(text: payload.description), decoration: textFieldStyle)
                    : CopiedText(payload.description, maxLines: 1, overflow: TextOverflow.ellipsis)),
          ],
        ],
      ),
    );
  }
}
