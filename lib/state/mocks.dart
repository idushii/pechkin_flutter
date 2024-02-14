import 'package:pechkin_flutter/models/project_comment.dart';
import 'package:pechkin_flutter/models/project_item.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/models/project_request_group.dart';

final mockProjects = [
  ProjectItem(1, name: "Project 1", description: "Description 1"),
  ProjectItem(2, name: "Project 2", description: "Description 2"),
];

final mockProjectRequests = [
  ProjectRequest(
    id: 1,
    projectId: 1,
    groupId: 1,
    path: '/auth',
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
  ProjectRequest(id: 2, projectId: 1, groupId: 1, path: '/registration', name: "Registration", description: "Регистрация", type: RequestType.POST, payload: [
    ProjectRequestPayload.string('email', 'Email'),
    ProjectRequestPayload.string('name', 'Name'),
    ProjectRequestPayload.string('password', 'Password'),
    ProjectRequestPayload.boolean('confirm_email', 'Confirm email'),
  ], response: [
    ProjectRequestPayload.string('status', 'Status'),
  ]),
  ProjectRequest(
      id: 3,
      projectId: 1,
      groupId: 2,
      path: '/tasks',
      name: "Список задач",
      description: "Список задач",
      type: RequestType.GET,
      payload: [],
      response: [
        ProjectRequestPayload.int('id', 'Id'),
        ProjectRequestPayload.string('name', 'Наименование'),
        ProjectRequestPayload.string('text', 'Текст'),
        ProjectRequestPayload.string('status', 'Статус'),
        ProjectRequestPayload.string('executor', 'Исполнитель'),
        ProjectRequestPayload.string('creator', 'Создатель'),
        ProjectRequestPayload.string('date', 'Дата'),
      ]),
  ProjectRequest(id: 4, projectId: 1, groupId: 2, path: '/task', name: "Создание задачи", description: "Создание задачи", type: RequestType.POST, payload: [
    ProjectRequestPayload.string('name', 'Наименование'),
    ProjectRequestPayload.string('text', 'Текст'),
    ProjectRequestPayload.string('executor', 'Исполнитель'),
  ], response: [
    ProjectRequestPayload.int('status', 'Статус'),
  ]),
  ProjectRequest(
      id: 5,
      projectId: 1,
      groupId: 2,
      path: '/task/:id',
      name: "Изменение задачи",
      description: "Изменение задачи",
      type: RequestType.PUT,
      payload: [
        ProjectRequestPayload.string('name', 'Наименование'),
        ProjectRequestPayload.string('text', 'Текст'),
        ProjectRequestPayload.string('executor', 'Исполнитель'),
      ],
      response: [
        ProjectRequestPayload.int('status', 'Статус'),
      ]),
  ProjectRequest(
      id: 6,
      projectId: 1,
      groupId: 2,
      path: '/task/:id',
      name: "Удаление задачи",
      description: "Удаление задачи",
      type: RequestType.DELETE,
      payload: [],
      response: [
        ProjectRequestPayload.int('status', 'Статус'),
      ])
];

final List<ProjectRequestGroup> mockProjectGroups = [
  ProjectRequestGroup(
    id: 1,
    projectId: 1,
    parentId: 0,
    name: "Авторизация",
    description: "Авторизация",
    requests: mockProjectRequests.where((element) => element.groupId == 1).toList(),
    comments: [],
  ),
  ProjectRequestGroup(
    id: 2,
    projectId: 1,
    parentId: 0,
    name: "Доска задач",
    description: "Доска задач",
    requests: mockProjectRequests.where((element) => element.groupId == 2).toList(),
    comments: [],
  )
];

final List<ProjectComment> mocksComments = [
  ProjectComment(id: 1, projectId: 1, parentId: 0, path: "", text: "Комментарий 1", requestId: 1),
  ProjectComment(id: 2, projectId: 1, parentId: 0, path: "", text: "Комментарий 2", requestId: 1),
  ProjectComment(id: 3, projectId: 1, parentId: 0, path: "", text: "Комментарий 3", requestId: 3),
];