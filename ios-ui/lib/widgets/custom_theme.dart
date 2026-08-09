import 'package:flutter/cupertino.dart';

import '../utils/constants.dart';

/// Pure Apple Cupertino theme — no Material Design inheritance.
class MyTheme {
  static const cupertino = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: Color(0xF7F9F9F9),
    scaffoldBackgroundColor: scaffoldBgColor,
    applyThemeToAll: true,
  );
}
