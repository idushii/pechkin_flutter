import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_view_request_payload_item.dart';
import 'package:highlight/languages/json.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:flutter_highlight/themes/monokai.dart';
import 'package:flutter_highlight/themes/solarized-light.dart';
import 'package:pechkin_flutter/shared/json_format.dart';

class ProjectViewRequestPayload extends StatefulWidget {
  final List<ProjectRequestPayload> payload;
  final String title;
  final bool isEdit;
  final String defaultType;
  final Function(List<ProjectRequestPayload> payload) onEdit;

  const ProjectViewRequestPayload(
      {super.key,
      required this.payload,
      required this.title,
      required this.isEdit,
      required this.onEdit,
      required this.defaultType});

  @override
  State<ProjectViewRequestPayload> createState() => _ProjectViewRequestPayloadState();
}

class _ProjectViewRequestPayloadState extends State<ProjectViewRequestPayload> {
  bool isJson = false;

  final controller = CodeController(
    text: '{}', // Initial code
    language: java,
  );

  fidNode(dynamic map, List<String> path, String name) {
    if (path.isEmpty) {
      return map[name];
    }

    if (path.length == 1) {
      return map[path[0]] ?? map['${path[0]}[]'];
    }

    return fidNode(map[path[0]], path.sublist(1), name);
  }

  updValueJson() {
    Map<String, dynamic> res = {};

    for (var i = 0; i < widget.payload.length; i++) {
      final item = widget.payload[i];
      if (widget.payload[i].path.isNotEmpty) {
        var node = fidNode(res, widget.payload[i].path, item.name);

        switch (item.type) {
          case ProjectRequestPayloadType.STRING:
            node[item.name] = '';
            break;
          case ProjectRequestPayloadType.INT:
            node[item.name] = 0;
            break;
          case ProjectRequestPayloadType.BOOLEAN:
            node[item.name] = false;
            break;
          case ProjectRequestPayloadType.DOUBLE:
            node[item.name] = 0.0;
            break;
          case ProjectRequestPayloadType.DATE:
            node[item.name] = '2000-01-01';
            break;
          case ProjectRequestPayloadType.DATE_TIME:
            node[item.name] = '2000-01-01T00:00:00';
            break;
          case ProjectRequestPayloadType.FILE:
            node[item.name] = "<FILE>";
            break;
          case ProjectRequestPayloadType.OBJECT:
            node[item.name] = {};
            break;
          case ProjectRequestPayloadType.ARRAY:
            node[item.name] = [];
            break;
        }
      } else {
        if (item.isArray || item.type == ProjectRequestPayloadType.ARRAY) {
          res['${widget.payload[i].name}[]'] = {};
        } else if (item.type == ProjectRequestPayloadType.OBJECT) {
          res[widget.payload[i].name] = {};
        } else {
          res[widget.payload[i].name] = widget.payload[i].description;
        }
      }
    }

    String res2 = jsonFormat(res);

    controller.text = res2;
  }

  @override
  void initState() {
    updValueJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(child: SelectableText(widget.title, style: Theme.of(context).textTheme.titleMedium)),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: Text("JSON", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.blue)),
            onPressed: () {
              setState(() {
                isJson = !isJson;
              });
            },
          )
        ]),
        if (isJson)
          CodeTheme(
            data: CodeThemeData(styles: solarizedLightTheme), // <= Pre-defined in flutter_highlight.
            child: CodeField(
              controller: controller,
            ),
          ),
        if (!isJson) ...[
          for (var i = 0; i < widget.payload.length; i++)
            ProjectViewRequestPayloadItem(
              payload: widget.payload[i],
              isLast: false,
              isEdit: widget.isEdit,
              onDelete: () {
                widget.onEdit([...widget.payload.sublist(0, i), ...widget.payload.sublist(i + 1)]);
              },
              onEdit: (item) {
                widget.onEdit([...widget.payload.sublist(0, i), item, ...widget.payload.sublist(i + 1)]);
              },
            ),
          if (widget.isEdit)
            ProjectViewRequestPayloadItem(
              payload: ProjectRequestPayload.empty().copyWith(type: widget.defaultType),
              isLast: true,
              isEdit: true,
              onDelete: () {},
              onEdit: (item) {
                widget.onEdit([...widget.payload, item]);
              },
            )
        ]
      ],
    );
  }
}
