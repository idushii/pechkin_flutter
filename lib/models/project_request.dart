import 'package:pechkin_flutter/models/index.dart';
import 'package:pechkin_flutter/models/project_request_sample.dart';

class RequestType {
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String DELETE = 'delete';
  static const String PATCH = 'patch';
}



class ProjectRequest {
  final int id;
  final int projectId;
  final int groupId;
  final String path;
  final String name;
  final String description;
  final String type;
  final List<ProjectRequestPayload> headers;
  final List<ProjectRequestPayload> payload;
  final List<ProjectRequestPayload> response;
  final List<ProjectRequestSample> samples;

  ProjectRequest({
    required this.id,
    required this.projectId,
    required this.groupId,
    required this.path,
    required this.name,
    required this.description,
    required this.type,
    required this.headers,
    required this.payload,
    required this.response,
    required this.samples
  });

  static ProjectRequest fromMap(Map<String, dynamic> json) {
    return ProjectRequest(
      id: json['id'] ?? 0,
      projectId: json['projectId'] ?? 0,
      groupId: json['groupId'] ?? 0,
      path: json['path'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? RequestType.GET,
      headers: (json['headers'] as List).map((e) => ProjectRequestPayload.fromMap(e)).toList(),
      payload: (json['payload'] as List).map((e) => ProjectRequestPayload.fromMap(e)).toList(),
      response: (json['response'] as List).map((e) => ProjectRequestPayload.fromMap(e)).toList(),
      samples: json['samples'] != null ? (json['samples'] as List).map((e) => ProjectRequestSample.fromMap(e)).toList() : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'projectId': projectId,
      'groupId': groupId,
      'path': path,
      'name': name,
      'description': description,
      'type': type,
      'headers': headers.map((e) => e.toMap()).toList(),
      'payload': payload.map((e) => e.toMap()).toList(),
      'response': response.map((e) => e.toMap()).toList(),
      'samples': samples.map((e) => e.toMap()).toList(),
    };
  }

  static ProjectRequest empty() {
    return ProjectRequest(
      id: 0,
      projectId: 0,
      groupId: 0,
      path: '',
      name: '',
      description: '',
      type: RequestType.GET,
      headers: [],
      payload: [],
      response: [],
      samples: [],
    );
  }
}
