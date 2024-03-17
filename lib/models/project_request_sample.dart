import 'package:pechkin_flutter/shared/json_format.dart';

class ProjectRequestSample {
  final int requestId;
  final String title;
  final String url;
  final String error;
  final int statusCode;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> serverHeaders;
  final Map<String, dynamic> payload;
  final Map<String, dynamic> response;

  ProjectRequestSample({required this.requestId,
    required this.title,
    required this.url,
    required this.error,
    required this.statusCode,
    required this.headers,
    required this.serverHeaders,
    required this.payload,
    required this.response});

  static ProjectRequestSample fromMap(Map<String, dynamic> json) {
    return ProjectRequestSample(
      requestId: json['requestId'] ?? 0,
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      error: json['error'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      headers: json['headers'] ?? {},
      serverHeaders: json['serverHeaders'] ?? {},
      payload: json['payload'] ?? {},
      response: json['response'] ?? {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'title': title,
      'url': url,
      'error': error,
      'statusCode': statusCode,
      'headers': headers,
      'serverHeaders': serverHeaders,
      'payload': payload,
      'response': response,
    };
  }


  static ProjectRequestSample empty() {
    return ProjectRequestSample(
      requestId: 0,
      title: '',
      url: '',
      error: '',
      statusCode: 0,
      headers: {},
      serverHeaders: {},
      payload: {},
      response: {},
    );
  }

  ProjectRequestSample copyWith({
    int? requestId,
    String? title,
    String? url,
    String? error,
    int? statusCode,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? serverHeaders,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? response,
  }) {
    return ProjectRequestSample(
      requestId: requestId ?? this.requestId,
      title: title ?? this.title,
      url: url ?? this.url,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      headers: headers ?? this.headers,
      serverHeaders: serverHeaders ?? this.serverHeaders,
      payload: payload ?? this.payload,
      response: response ?? this.response,
    );
  }
}
