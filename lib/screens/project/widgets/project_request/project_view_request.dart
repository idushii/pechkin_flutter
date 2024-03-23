import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pechkin_flutter/models/index.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_request_desc.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_request_tab.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_request_title.dart';
import 'package:pechkin_flutter/screens/project/widgets/project_request/project_view_request_payload.dart';
import 'package:pechkin_flutter/state/mocks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProjectViewRequest extends StatefulWidget {
  final int id;

  const ProjectViewRequest({super.key, required this.id});

  @override
  State<ProjectViewRequest> createState() => _ProjectViewRequestState();
}

class _ProjectViewRequestState extends State<ProjectViewRequest> {
  ProjectRequest request = ProjectRequest.empty();
  bool isEdit = false;
  int indexTab = 0;

  FormGroup form = FormGroup({
    'name': FormControl<String>(value: ''),
    'description': FormControl<String>(value: ''),
    'type': FormControl<String>(value: ''),
    'path': FormControl<String>(value: ''),
  });

  @override
  void initState() {
    request =
        mockProjectRequests.firstWhere((element) => element.id == widget.id, orElse: () => ProjectRequest.empty());

    form.value = {
      'name': request.name,
      'description': request.description,
      'type': request.type,
      'path': request.path,
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (request.id == 0) {
      return const Center(child: Text('Запрос не найден'));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProjectRequestTitle(
                request: request,
                form: form,
                isEdit: isEdit,
                onEdit: () {
                  setState(() {
                    isEdit = !isEdit;
                  });
                }),
            const SizedBox(height: 10),
            ProjectRequestDesc(request: request, form: form, isEdit: isEdit),
            const SizedBox(height: 10),
            ProjectRequestTab(
              onSelect: (index) => setState(() => indexTab = index),
              request: request,
            ),
            const SizedBox(height: 10),
            ProjectViewRequestPayload(
              payload: request.headers,
              defaultType: ProjectRequestPayloadType.NOT_TYPE,
              title: 'Заголовки',
              isEdit: isEdit,
              onEdit: (payload) {
                setState(() {
                  request.headers.clear();
                  request.headers.addAll(payload);
                });
              },
            ),
            const SizedBox(height: 10),
            ProjectViewRequestPayload(
              payload: request.payload,
              defaultType: ProjectRequestPayloadType.STRING,
              title: 'Данные для отправки',
              isEdit: isEdit,
              onEdit: (payload) {
                setState(() {
                  request.payload.clear();
                  request.payload.addAll(payload);
                });
              },
            ),
            const SizedBox(height: 10),
            ProjectViewRequestPayload(
              payload: request.response,
              defaultType: ProjectRequestPayloadType.STRING,
              title: 'Ответ',
              isEdit: isEdit,
              onEdit: (payload) {
                setState(() {
                  request.response.clear();
                  request.response.addAll(payload);
                });
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
