import 'package:pechkin_flutter/index.dart';

class ProjectItemFull {
  final int id;
  final String name;
  final String description;

  final List<ProjectRequestGroup> groups;

  ProjectItemFull({required this.id, required this.name, required this.description, required this.groups});

  // empty
  static ProjectItemFull empty() {
    return ProjectItemFull(id: 0, name: '', description: '', groups: []);
  }

  // copyWith
  ProjectItemFull copyWith({int? id, String? name, String? description, List<ProjectRequestGroup>? groups}) {
    return ProjectItemFull(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      groups: groups ?? this.groups
    );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'groups': groups.map((x) => x.toMap()).toList(),
    };
  }

  // fromMap
  factory ProjectItemFull.fromMap(Map<String, dynamic> map) {
    return ProjectItemFull(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      groups: List<ProjectRequestGroup>.from(map['groups']?.map((x) => ProjectRequestGroup.fromMap(x))),
    );
  }
}