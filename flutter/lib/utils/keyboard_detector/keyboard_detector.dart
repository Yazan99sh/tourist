import 'package:flutter/cupertino.dart';

class KeyboardDetector {
  static bool isUp(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0;
  }
}