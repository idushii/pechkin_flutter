import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/shared/copied_text.dart';
import 'package:pechkin_flutter/shared/typed/is_obj.dart';

class ProjectViewRequestPayloadItem extends StatelessWidget {
  final ProjectRequestPayload payload;
  final bool isLast;
  final bool isEdit;

  const ProjectViewRequestPayloadItem({super.key, required this.payload, required this.isLast, required this.isEdit});

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
          Container(
            width: isObj(payload.type) ? (isNoCompact ? 245 : 230) : 200,
            child: isEdit ? TextFormField(controller: TextEditingController(text: name), decoration: textFieldStyle) : CopiedText(name, minWidth: 700),
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
                          // TODO
                        })
                    : CopiedText(payload.type)),
          Expanded(
              flex: 3,
              child: isEdit
                  ? TextFormField(controller: TextEditingController(text: payload.description), decoration: textFieldStyle)
                  : CopiedText(payload.description, maxLines: 1, overflow: TextOverflow.ellipsis)),
          if (isEdit)
          GestureDetector(
            onTap: () {
              // TODO
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(Icons.remove, size: size * 2),
            ),
          ),
        ],
      ),
    );
  }
}
