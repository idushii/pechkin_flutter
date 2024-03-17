import 'package:flutter/material.dart';

class Styles {
  static final btnTab = ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
  );
  static final btnTab2 = ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
    foregroundColor: MaterialStateProperty.all(Colors.blue),
  );
}