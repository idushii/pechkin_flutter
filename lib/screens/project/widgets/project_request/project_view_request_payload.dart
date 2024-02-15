import 'package:flutter/cupertino.dart';
import 'package:pechkin_flutter/models/project_request.dart';

class ProjectViewRequestPayload extends StatelessWidget {
  final ProjectRequestPayload payload;
  const ProjectViewRequestPayload({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(payload.name)),
        Expanded(child: Text(payload.description)),
        Expanded(child: Text(payload.type)),
        Expanded(child: Text(payload.isArray.toString())),
      ]
    );
  }
}