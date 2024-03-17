import 'package:pechkin_flutter/models/project_request_payload_type.dart';

class ProjectRequestPayload {
  final List<String> path;
  final String name;
  final String description;
  final String type;
  final bool isArray;

  ProjectRequestPayload(this.path, {required this.name, required this.description, required this.type, required this.isArray});

  // from map
  static ProjectRequestPayload fromMap(Map<String, dynamic> json) {
    return ProjectRequestPayload(
      json['path'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      isArray: json['isArray'],
    );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'name': name,
      'description': description,
      'type': type,
      'isArray': isArray,
    };
  }

  // empty
  static ProjectRequestPayload empty() {
    return ProjectRequestPayload(
      [],
      name: '',
      description: '',
      type: ProjectRequestPayloadType.STRING,
      isArray: false,
    );
  }

  ProjectRequestPayload copyWith({
    List<String>? path,
    String? name,
    String? description,
    String? type,
    bool? isArray,
  }) {
    return ProjectRequestPayload(
      path ?? this.path,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      isArray: isArray ?? this.isArray,
    );
  }

  static ProjectRequestPayload string(String name, String desc, [ List<String> path = const [], bool isArray = false]) {
    return ProjectRequestPayload(
      path,
      name: name,
      description: desc,
      type: ProjectRequestPayloadType.STRING,
      isArray: isArray,
    );
  }

  static ProjectRequestPayload notType(String name, String desc, [ List<String> path = const [], bool isArray = false]) {
    return ProjectRequestPayload(
      path,
      name: name,
      description: desc,
      type: ProjectRequestPayloadType.NOT_TYPE,
      isArray: isArray,
    );
  }

  static ProjectRequestPayload int(String name, String desc, [ List<String> path = const [], bool isArray = false]) {
    return ProjectRequestPayload(
      path,
      name: name,
      description: desc,
      type: ProjectRequestPayloadType.INT,
      isArray: isArray,
    );
  }

  static ProjectRequestPayload double(String name, String desc, [ List<String> path = const [], bool isArray = false]) {
    return ProjectRequestPayload(
      path,
      name: name,
      description: desc,
      type: ProjectRequestPayloadType.DOUBLE,
      isArray: isArray,
    );
  }

  static ProjectRequestPayload boolean(String name, String desc, [ List<String> path = const [], bool isArray = false]) {
    return ProjectRequestPayload(
      path,
      name: name,
      description: desc,
      type: ProjectRequestPayloadType.BOOLEAN,
      isArray: isArray,
    );
  }
}
