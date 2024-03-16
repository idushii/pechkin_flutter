class RequestType {
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String DELETE = 'delete';
  static const String PATCH = 'patch';
}

class ProjectRequestPayloadType {
  static const String NOT_TYPE = 'not_type';
  static const String STRING = 'string';
  static const String INT = 'int';
  static const String DOUBLE = 'double';
  static const String BOOLEAN = 'boolean';
  static const String DATE = 'date';
  static const String DATE_TIME = 'date_time';
  static const String FILE = 'file';
  static const String ARRAY = 'array';
  static const String OBJECT = 'object';

  static const values = [STRING, INT, DOUBLE, BOOLEAN, DATE, DATE_TIME, FILE, ARRAY, OBJECT];
}

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
    );
  }
}
