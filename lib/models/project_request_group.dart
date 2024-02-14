import 'package:pechkin_flutter/models/project_comment.dart';
import 'package:pechkin_flutter/models/project_request.dart';

class ProjectRequestGroup {
  final int id;
  final int projectId;
  final int parentId;

  final String name;
  final String description;
  final List<ProjectRequest> requests;
  final List<ProjectComment> comments;


  ProjectRequestGroup({required this.id, required this.projectId, required this.parentId, required this.name, required this.description, required this.requests, required this.comments});

  // toMap
  Map<String, dynamic> toMap() {
    return {'id': id, 'projectId': projectId, 'parentId': parentId, 'name': name, 'description': description, 'requests': requests, 'comments': comments};
  }

  // from Map
  static ProjectRequestGroup fromMap(Map<String, dynamic> json) {
    return ProjectRequestGroup(
      id: json['id'] ?? 0,
      projectId: json['projectId'] ?? 0,
      parentId: json['parentId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      requests: (json['requests'] as List).map((e) => ProjectRequest.fromMap(e)).toList(),
      comments: (json['comments'] as List).map((e) => ProjectComment.fromMap(e)).toList(),
    );
  }

  // empty
  static ProjectRequestGroup empty() {
    return ProjectRequestGroup(
      id: 0,
      projectId: 0,
      parentId: 0,
      name: '',
      description: '',
      requests: [],
      comments: [],
    );
  }
}