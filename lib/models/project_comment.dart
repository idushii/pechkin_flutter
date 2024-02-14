class ProjectComment {
  final int id;
  final int projectId;
  final int parentId;
  final int requestId;

  final String path;
  final String text;

  ProjectComment({required this.id, required this.projectId, required this.parentId, required this.requestId, required this.path, required this.text});

  // toMap
  Map<String, dynamic> toMap() {
    return {'id': id, 'projectId': projectId, 'parentId': parentId, 'path': path, 'text': text};
  }

  // from Map
  static ProjectComment fromMap(Map<String, dynamic> json) {
    return ProjectComment(
      id: json['id'] ?? 0,
      projectId: json['projectId'] ?? 0,
      parentId: json['parentId'] ?? 0,
      requestId: json['requestId'] ?? 0,
      path: json['path'] ?? '',
      text: json['text'] ?? '',
    );
  }

  // empty
  static ProjectComment empty() {
    return ProjectComment(
      id: 0,
      projectId: 0,
      parentId: 0,
      requestId: 0,
      path: '',
      text: '',
    );
  }
}
