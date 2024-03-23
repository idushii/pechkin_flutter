import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/screens/project/project_edit_screen.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_actions.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_groups.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_info.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_view_request.dart';
import 'package:pechkin_flutter/shared/splitter.dart';
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

  double initW = 0;
  Key keySplitter = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProjectViewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      keySplitter = UniqueKey();
      initW = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final project = mockProjects.firstWhere((project) => project.id == widget.id);
    final groups = mockProjectGroups.where((element) => element.projectId == widget.id);
    final w = MediaQuery.of(context).size.width;

    if (initW == 0) {
      initW = w;
    } else {
      if (initW != w) {
        keySplitter = UniqueKey();
        initW = w;
      }
    }

    print(w);

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
              child: w > 700
                  ? Splitter(
                      key: keySplitter,
                      axis: Axis.horizontal,
                      initialFractions: (() {
                        if (initW > 1500) {
                          return [0.2, 0.8];
                        }

                        if (initW > 1000) {
                          return [0.3, 0.7];
                        }

                        if (initW > 700) {
                          return [0.4, 0.6];
                        }

                        return [0.5, 0.5];
                      })(),
                      children: [
                        ProjectsGroupsList(
                            groups: groups.toList(),
                            id: widget.id,
                            onTapRequest: (id) {
                              setState(() {
                                selectedRequest = id;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            key: Key('project_view_request_${selectedRequest}'),
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (selectedRequest == 0) ProjectInfo(project: project),
                              if (selectedRequest > 0) Expanded(child: ProjectViewRequest(id: selectedRequest))
                            ],
                          ),
                        ),
                      ],
                    )
                  : ProjectsGroupsList(
                      groups: groups.toList(),
                      id: widget.id,
                      onTapRequest: (id) {
                        setState(() {
                          selectedRequest = id;
                        });
                      }),
            ),
          ]),
        ));
  }
}
