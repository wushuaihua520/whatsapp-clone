import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MyTheme {
  static final theme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBgColor,
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: primaryColor,
      barBackgroundColor: navBarBg,
      scaffoldBackgroundColor: scaffoldBgColor,
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.white),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: Colors.transparent,
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: false,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.4,
      ),
      iconTheme: IconThemeData(color: Colors.black, size: 22),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontSize: 12,
        height: 1.3,
        color: textColor,
        letterSpacing: -0.2,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.35,
        color: textColor,
        letterSpacing: -0.3,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        height: 1.35,
        color: textColor,
        letterSpacing: -0.2,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        height: 1.2,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      titleLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        color: Colors.black,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: separatorColor,
      thickness: 0.5,
      space: 0.5,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll<double>(0.0),
        splashFactory: NoSplash.splashFactory,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
        shadowColor: const WidgetStatePropertyAll<Color>(transparent),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: Color(0x3325D366),
      selectionHandleColor: primaryColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
  );
}
