import 'package:pechkin_flutter/models/project_request.dart';
import 'package:pechkin_flutter/models/project_request_payload_type.dart';

isObj(String type) {
  if (type == ProjectRequestPayloadType.OBJECT || type == ProjectRequestPayloadType.ARRAY) {
    return true;
  }

  return false;
}