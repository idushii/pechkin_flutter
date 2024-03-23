import 'package:pechkin_flutter/models/index.dart';

isObj(String type) {
  if (type == ProjectRequestPayloadType.OBJECT || type == ProjectRequestPayloadType.ARRAY) {
    return true;
  }

  return false;
}
