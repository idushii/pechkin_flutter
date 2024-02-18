import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_item.dart';
import 'package:pechkin_flutter/models/project_request.dart';
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
    final project = mockProjects.firstWhere((project) => project.id == projectId, orElse: () => ProjectItem.empty());
    final request = mockProjectRequests.firstWhere((element) => element.id == requestId, orElse: () => ProjectRequest.empty());
    if (request.id == 0) {
      return const Center(child: Text('Запрос не найден'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Просмотр запроса"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: SingleChildScrollView(child: ProjectViewRequest(id: requestId)),
        ),
      ),
    );
  }
}
