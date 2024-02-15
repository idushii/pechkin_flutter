import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request_group.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request_list.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectGroupsList extends StatefulWidget {
  final int groupId;
  final Function(int id) onTapRequest;
  final int selectedRequest;

  const ProjectGroupsList({super.key, required this.groupId, required this.onTapRequest, required this.selectedRequest});

  @override
  State<ProjectGroupsList> createState() => _ProjectGroupsListState();
}

class _ProjectGroupsListState extends State<ProjectGroupsList> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final groups = mockProjectGroups.firstWhere((element) => element.id == widget.groupId, orElse: () => ProjectRequestGroup.empty());
    final children = mockProjectGroups.where((element) => element.parentId == widget.groupId);

    return Column(
      children: [
        ListTile(
          onTap: () => setState(() => isExpanded = !isExpanded),
          leading: Icon(isExpanded ? Icons.expand_more : Icons.expand_less),
          title: Text(groups.name, style: Theme.of(context).textTheme.titleMedium),
          trailing: PopupMenuButton(
            onSelected: (value) {},
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 1, child: Text('Добавить запрос')),
                const PopupMenuItem(value: 1, child: Text('Изменить')),
                const PopupMenuItem(value: 1, child: Text('Поделиться')),
              ];
            }
          )),
        if (children.isNotEmpty && isExpanded)
          for (var group in children) ProjectGroupsList(groupId: group.id, onTapRequest: widget.onTapRequest, selectedRequest: widget.selectedRequest),
        if (children.isEmpty && isExpanded)
          ProjectRequestList(groupId: widget.groupId, onTapRequest: widget.onTapRequest, selectedRequest: widget.selectedRequest),
      ],
    );
  }
}
