import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pechkin_flutter/models/project_request_group.dart';
import 'package:pechkin_flutter/screens/project/project_request_screen.dart';
import 'package:pechkin_flutter/screens/project/widgets/projects_groups_list.dart';

class ProjectsGroupsList extends StatefulWidget {
  final int id;
  final List<ProjectRequestGroup> groups;
  final Function(int) onTapRequest;

  const ProjectsGroupsList({super.key, required this.groups, required this.id, required this.onTapRequest});

  @override
  State<ProjectsGroupsList> createState() => _ProjectsGroupsListState();
}

class _ProjectsGroupsListState extends State<ProjectsGroupsList> {

  int selectedRequest = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: widget.groups.length,
      itemBuilder: (context, index) {
        return ProjectGroupsList(
            selectedRequest: selectedRequest,
            groupId: widget.groups.elementAt(index).id,
            onTapRequest: (id) {
              setState(() => selectedRequest = id);
              widget.onTapRequest(id);
              if (w <= 700) {
                context.goNamed(ProjectRequestScreen.routeName, pathParameters: {
                  'id': widget.id.toString(),
                  'requestId': selectedRequest.toString(),
                });
              }
            });
      },
    );
  }
}