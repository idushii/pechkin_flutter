import 'package:flutter/cupertino.dart';
import 'package:pechkin_flutter/models/project_request_group.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request_list.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectGroupsList extends StatelessWidget {
  final int groupId;

  const ProjectGroupsList({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    final groups = mockProjectGroups.firstWhere((element) => element.id == groupId, orElse: () => ProjectRequestGroup.empty());
    final children = mockProjectGroups.where((element) => element.parentId == groupId);

    return Column(
      children: [
        Text(groups.name),
        if (children.isNotEmpty)
          for (var group in children) ProjectGroupsList(groupId: group.id),
        if (children.isEmpty)
          ProjectRequestList(groupId: groupId)
      ],
    );
  }
}
