import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/models/project_request_payload.dart';
import 'package:pechkin_flutter/models/project_request_payload_type.dart';
import 'package:pechkin_flutter/shared/copied_text.dart';
import 'package:pechkin_flutter/shared/typed/is_obj.dart';

class ProjectViewRequestPayloadItem extends StatelessWidget {
  final ProjectRequestPayload payload;
  final bool isLast;
  final bool isEdit;
  final Function(ProjectRequestPayload payload) onEdit;
  final Function() onDelete;

  const ProjectViewRequestPayloadItem({super.key, required this.payload, required this.isLast, required this.isEdit, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final name = "${payload.name}${(payload.type == ProjectRequestPayloadType.ARRAY || payload.isArray) ? '[]' : ''}";
    final isNoCompact = MediaQuery.of(context).size.width > 600;

    final textFieldStyle = InputDecoration(
      contentPadding: isNoCompact ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5) : const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      isDense: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.zero,
      ),
    );

    double size = isEdit ? 20 : 10;
    if (isEdit) {
      if (isNoCompact) {
        size = 15;
      } else {
        size = 10;
      }
    }

    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController typeController = TextEditingController( text: payload.type.toString());
    final TextEditingController descController = TextEditingController( text: payload.description);

    return Form(
      onChanged: () {
        if (!isLast) {
          onEdit(
              payload.copyWith(name: nameController.text, type: typeController.text, description: descController.text));
          }
      },
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
          SizedBox(
            width: isEdit ? (isObj(payload.type) ? (isNoCompact ? 245 : 230) : 200) : isObj(payload.type) ? 230 : 200,
            child: isEdit ? TextFormField(controller: nameController, decoration: textFieldStyle) : CopiedText(name, minWidth: 700),
          ),
          if (payload.type != ProjectRequestPayloadType.NOT_TYPE)
            SizedBox(
                width: 130,
                child: isEdit
                    ? DropdownButtonFormField<String>(
                        value: payload.type,
                        items: [for (var v in ProjectRequestPayloadType.values) DropdownMenuItem(value: v, child: Text(v))],
                        decoration: textFieldStyle,
                        onChanged: (value) {
                          if (value != null) {
                            typeController.text = value;
                          }
                        })
                    : CopiedText(payload.type)),
          Expanded(
              flex: 3,
              child: isEdit
                  ? TextFormField(controller: descController, decoration: textFieldStyle)
                  : CopiedText(payload.description, maxLines: 1, overflow: TextOverflow.ellipsis)),
          if (isEdit)
          GestureDetector(
            onTap: () {
              if  (isLast) {
                onEdit(ProjectRequestPayload(
                  payload.path,
                  name: nameController.text,
                  type: typeController.text,
                  isArray: payload.isArray,
                  description: descController.text
                ));
              } else {
                onDelete();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon( isLast ? Icons.add : Icons.remove, size: size * 2),
            ),
          ),
        ],
      ),
    );
  }
}
