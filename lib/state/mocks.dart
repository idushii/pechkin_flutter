import 'package:pechkin_flutter/models/project_item.dart';
import 'package:pechkin_flutter/models/project_request.dart';

final mockProjects = [
  ProjectItem(1, name: "Project 1", description: "Description 1"),
  ProjectItem(2, name: "Project 2", description: "Description 2"),
];

final mockProjectRequests = [
  ProjectRequest(
    id: 1,
    projectId: 1,
    name: "Auth",
    description: "Авторизация",
    type: RequestType.POST,
    payload: [
      ProjectRequestPayload.string('email', 'Email'),
      ProjectRequestPayload.string('password', 'Password'),
    ],
    response: [
      ProjectRequestPayload.string('token', 'Token'),
      ProjectRequestPayload.int('exp', 'Exp'),
      ProjectRequestPayload.string('refresh_token', 'Refresh token'),
    ],
  ),
  ProjectRequest(
    id: 2,
    projectId: 1,
    name: "Registration",
    description: "Регистрация",
    type: RequestType.POST,
    payload: [
      ProjectRequestPayload.string('email', 'Email'),
      ProjectRequestPayload.string('name', 'Name'),
      ProjectRequestPayload.string('password', 'Password'),
      ProjectRequestPayload.boolean('confirm_email', 'Confirm email'),
    ],
    response: [
      ProjectRequestPayload.string('status', 'Status'),
    ]
  )
];
