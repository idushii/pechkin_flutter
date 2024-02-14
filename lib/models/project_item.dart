class ProjectItem {
  final int id;
  final String name;
  final String description;

  ProjectItem(this.id, {required this.name, required this.description});

  static ProjectItem fromMap(Map<String, dynamic> json) {
    return ProjectItem(
      json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  // empty
  static ProjectItem empty() {
    return ProjectItem(0, name: '', description: '');
  }

  // copyWith
  ProjectItem copyWith({int? id, String? name, String? description}) {
    return ProjectItem(
      id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}