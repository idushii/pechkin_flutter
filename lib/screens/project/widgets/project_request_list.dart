import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/project_request_group.dart';
import 'package:pechkin_flutter/state/mocks.dart';

class ProjectRequestList extends StatelessWidget {
  final int groupId;

  const ProjectRequestList({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    final requests = mockProjectGroups.firstWhere((element) => element.id == groupId, orElse: () => ProjectRequestGroup.empty()).requests;

    return Column(children: [
      for (var request in requests)
        ListTile(
          leading: SizedBox(),
            title: Text(request.name),
            subtitle: Text("[${request.type.toUpperCase()}] ${request.path}"),
            trailing: PopupMenuButton(
              onSelected: (value) {},
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(value: 1, child: Text('Изменить')),
                  const PopupMenuItem(value: 1, child: Text('Удалить')),
                ];
              },
            ),
            onTap: () {})
    ]);
  }
}
