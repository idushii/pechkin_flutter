import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_view_request.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectRequestScreen extends StatelessWidget {
  final projectId;
  final requestId;

  const ProjectRequestScreen({super.key, this.requestId, this.projectId});

  static const route = "request/:requestId";
  static const routeName = "project_request";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Проект ${projectId} Запрос ${requestId}"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10),
          child: ProjectViewRequest(id: requestId),
        ),
      ),
    );
  }
}
