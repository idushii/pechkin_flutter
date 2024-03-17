import 'package:pechkin_flutter/models/project_comment.dart';
import 'package:pechkin_flutter/models/project_item.dart';
import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/models/project_request_group.dart';
import 'package:pechkin_flutter/models/project_request_payload.dart';
import 'package:pechkin_flutter/models/project_request_payload_type.dart';
import 'package:pechkin_flutter/models/project_request_sample.dart';

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
    headers: [ProjectRequestPayload.notType('Content-Type', 'application/json')],
    payload: [
      ProjectRequestPayload.string('email', 'Email'),
      ProjectRequestPayload.string('password', 'Password'),
    ],
    response: [
      ProjectRequestPayload.string('token', 'Token'),
      ProjectRequestPayload.int('exp', 'Exp'),
      ProjectRequestPayload.string('refresh_token', 'Refresh token'),
    ],
    samples: [],
  ),
  ProjectRequest(
    id: 2,
    projectId: 1,
    groupId: 1,
    path: '/registration',
    name: "Registration",
    description: "Регистрация",
    type: RequestType.POST,
    headers: [ProjectRequestPayload.notType('Content-Type', 'application/json')],
    payload: [
      ProjectRequestPayload.string('email', 'Email'),
      ProjectRequestPayload.string('name', 'Name'),
      ProjectRequestPayload.string('password', 'Password'),
      ProjectRequestPayload.boolean('confirm_email', 'Confirm email'),
    ],
    response: [
      ProjectRequestPayload.string('status', 'Status'),
    ],
    samples: [],
  ),
  ProjectRequest(
    id: 3,
    projectId: 1,
    groupId: 2,
    path: '/tasks',
    name: "Список задач",
    description: "Список задач",
    type: RequestType.GET,
    payload: [
      ProjectRequestPayload.int('page', 'Страница'),
      ProjectRequestPayload.int(
        'limit',
        'На странице',
      ),
    ],
    response: [
      ProjectRequestPayload([],
          name: 'items', description: 'items', isArray: false, type: ProjectRequestPayloadType.ARRAY),
      ProjectRequestPayload.int('id', 'Id', ['items']),
      ProjectRequestPayload.string('name', 'Наименование', ['items']),
      ProjectRequestPayload.string('text', 'Текст', ['items']),
      ProjectRequestPayload.string('status', 'Статус', ['items']),
      ProjectRequestPayload.string('executor', 'Исполнитель', ['items']),
      ProjectRequestPayload.string('creator', 'Создатель', ['items']),
      ProjectRequestPayload.string('date', 'Дата', ['items']),
      ProjectRequestPayload([],
          name: 'meta', description: 'meta', isArray: false, type: ProjectRequestPayloadType.OBJECT),
      ProjectRequestPayload.int('total', 'Всего', ['meta']),
      ProjectRequestPayload.int('page', 'Страница', ['meta']),
      ProjectRequestPayload.int('limit', 'На странице', ['meta']),
      ProjectRequestPayload([],
          name: 'append', description: 'append', isArray: true, type: ProjectRequestPayloadType.OBJECT),
      ProjectRequestPayload.int('append', 'Дополнительные данные', ['append']),
      ProjectRequestPayload([],
          name: 'tags', description: 'tags', isArray: true, type: ProjectRequestPayloadType.ARRAY),
      ProjectRequestPayload.int('id', 'id', ['tags']),
      ProjectRequestPayload.string('name', 'Наименование', ['tags']),
    ],
    headers: [ProjectRequestPayload.notType('Content-Type', 'application/json')],
    samples: [
      ProjectRequestSample(
        requestId:  3,
        serverHeaders: {},
        statusCode: 200,
        url: '/tasks?page=1&limit=10',
        title: 'Пример 1',
        method: RequestType.GET,
        headers: {},
        payload: {},
        response: {
          "items": [
            {
              "id": 1,
              "name": "Task 1",
              "text": "Text 1",
              "status": "status 1",
              "executor": "executor 1",
              "creator": "creator 1",
              "date": "date 1"
            },
            {
              "id": 2,
              "name": "Task 2",
              "text": "Text 2",
              "status": "status 2",
              "executor": "executor 2",
              "creator": "creator 2",
              "date": "date 2"
            },
          ],
          "meta": {"total": 2, "page": 1, "limit": 10},
          "append": [],
          "tags": [
            {"id": 1, "name": "Tag 1"}
          ]
        },
      )
    ],
  ),
  ProjectRequest(
    id: 4,
    projectId: 1,
    groupId: 2,
    path: '/task',
    name: "Создание задачи",
    description: "Создание задачи",
    type: RequestType.POST,
    payload: [
      ProjectRequestPayload.string('name', 'Наименование'),
      ProjectRequestPayload.string('text', 'Текст'),
      ProjectRequestPayload.string('executor', 'Исполнитель'),
    ],
    response: [
      ProjectRequestPayload.int('status', 'Статус'),
    ],
    headers: [ProjectRequestPayload.notType('Content-Type', 'application/json')],
    samples: [],
  ),
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
    ],
    headers: [ProjectRequestPayload.notType('Content-Type', 'application/json')],
    samples: [],
  ),
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
    ],
    headers: [ProjectRequestPayload.notType('Content-Type', 'application/json')],
    samples: [],
  ),
  ProjectRequest(
    id: 7,
    projectId: 1,
    groupId: 3,
    path: '/requests',
    name: "Получение запросов",
    description: "Получение запросов",
    type: RequestType.GET,
    payload: [],
    response: [
      ProjectRequestPayload([],
          name: 'items', description: 'items', type: ProjectRequestPayloadType.ARRAY, isArray: false),
      ProjectRequestPayload.string('path', 'Path', ['items']),
      ProjectRequestPayload.int('id', 'Id', ['items']),
      ProjectRequestPayload.string('name', 'Наименование', ['items']),
      ProjectRequestPayload.string('text', 'Описание', ['items']),
      ProjectRequestPayload.string('type', 'Тип', ['items']),
      ProjectRequestPayload.string('isArray', 'Это массив', ['items']),
    ],
    headers: [ProjectRequestPayload.notType('Content-Type', 'application/json')],
    samples: [],
  ),
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
  ),
  ProjectRequestGroup(
    id: 3,
    projectId: 1,
    parentId: 0,
    name: "Http запросы",
    description: "Http запросы",
    comments: [],
    requests: mockProjectRequests.where((element) => element.groupId == 3).toList(),
  )
];

final List<ProjectComment> mocksComments = [
  ProjectComment(id: 1, projectId: 1, parentId: 0, path: "", text: "Комментарий 1", requestId: 1),
  ProjectComment(id: 2, projectId: 1, parentId: 0, path: "", text: "Комментарий 2", requestId: 1),
  ProjectComment(id: 3, projectId: 1, parentId: 0, path: "", text: "Комментарий 3", requestId: 3),
];
