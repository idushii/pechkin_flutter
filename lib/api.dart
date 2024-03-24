import 'package:dio/dio.dart';
import 'package:pechkin_flutter/models/index.dart';

class ApiResponse<T> {
  T? data;
  String? error;

  ApiResponse({this.data, this.error});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['error'] = this.error;
    return data;
  }
}

class Api {
  static String baseUrl = 'http://localhost:5001/api';
  // static String baseUrl = 'http://10.0.2.2:5001/api';
  // static String baseUrl = 'https://auth.same-server.logging.network/api';

  static Dio dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {'Content-Type': 'application/json'}));

  static setHeader(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future auth(String login, String password) {
    return dio.post('/auth', data: {'login': login, 'password': password});
  }

  static Future<ApiResponse<User>> getMe() {
    return dio.get('/me').then((value) {
      return ApiResponse<User>(data: User.fromMap(value.data), error: null);
    }).catchError((e) => ApiResponse<User>(error: e.toString()));
  }

  static Future<ApiResponse<List<ProjectItem>>> getProjects() async {
    return dio.get('/projects').then((value) {
      final list = (List.from(value.data)).cast<Map<String, dynamic>>();
      final List<ProjectItem> data = list.map<ProjectItem>((e) => ProjectItem.fromMap(e)).toList();
      return ApiResponse(data: data, error: null);
    }).catchError((e) => ApiResponse<List<ProjectItem>>(error: e.toString()));
  }

  // create project
  static Future<ApiResponse<ProjectItem>> createProject(String name, String description) async {
    return dio.post('/projects', data: {'name': name, 'description': description}).then((value) {
      return ApiResponse(data: ProjectItem.fromMap(value.data), error: null);
    }).catchError((e) => ApiResponse<ProjectItem>(error: e.toString()));
  }

}