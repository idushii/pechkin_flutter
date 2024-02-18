import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/screens/home_screen.dart';
import 'package:pechkin_flutter/screens/project/project_edit_screen.dart';
import 'package:pechkin_flutter/screens/project/project_request_screen.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_actions.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_view_request.dart';
import 'package:pechkin_flutter/screens/project/widgets/projects_groups_list.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectViewScreen extends StatefulWidget {
  const ProjectViewScreen({super.key, required this.id});

  final int id;

  static const route = ":id";
  static const routeName = "project_view";

  @override
  State<ProjectViewScreen> createState() => _ProjectViewScreenState();
}

class _ProjectViewScreenState extends State<ProjectViewScreen> {
  int selectedRequest = 0;

  @override
  Widget build(BuildContext context) {
    final project = mockProjects.firstWhere((project) => project.id == widget.id);
    final groups = mockProjectGroups.where((element) => element.projectId == widget.id);
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(project.name),
          actions: [
            DropdownButton(
              value: 0,
              items: const [
                DropdownMenuItem(value: 0, child: Text("ENV не выбран")),
                DropdownMenuItem(value: 1, child: Text("Dev stand")),
                DropdownMenuItem(value: 2, child: Text("Test stand")),
              ],
              onChanged: (value) {},
            ),
            PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    context.goNamed(ProjectEditScreen.routeName, pathParameters: {'id': widget.id.toString()});
                  }
                },
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => projectActions)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(project.description),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    flex: w > 1000 ? 2 : 1,
                    child: ListView.builder(
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        return ProjectGroupsList(
                            selectedRequest: selectedRequest,
                            groupId: groups.elementAt(index).id,
                            onTapRequest: (id) {
                              setState(() => selectedRequest = id);
                              if (w <= 700) {
                                context.goNamed(ProjectRequestScreen.routeName, pathParameters: {
                                  'id': widget.id.toString(),
                                  'requestId': selectedRequest.toString(),
                                });
                              }
                            });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (w > 700)
                    Flexible(
                      flex: w > 1000 ? (w > 1300 ? 7 : 3) : 1,
                      child: Column(children: [
                        if (selectedRequest == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Переменные среды', style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 10),
                              const SelectableText('baseUrl: https://test.ru \ntoken: sdjkfhskdsdffahsdgfkjahsgdfjahsd \nisDev: true'),
                              const SizedBox(height: 20),
                              const SelectableText('Тут будет инфа, для выбранного маршрута'),
                            ],
                          ),
                        if (selectedRequest > 0) Expanded(child: ProjectViewRequest(id: selectedRequest))
                      ]),
                    ),
                ],
              ),
            ),
          ]),
        ));
  }
}
