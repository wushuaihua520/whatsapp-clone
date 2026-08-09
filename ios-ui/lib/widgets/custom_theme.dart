import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';

class MyTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    platform: TargetPlatform.iOS,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBgColor,
    splashFactory: InkRipple.splashFactory,
    visualDensity: VisualDensity.standard,
    cupertinoOverrideTheme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: iosBlue,
      scaffoldBackgroundColor: scaffoldBgColor,
      barBackgroundColor: iosGlassTint,
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: iosBlue,
      onSecondary: Colors.white,
      surface: scaffoldBgColor,
      onSurface: textColor,
      background: scaffoldBgColor,
      onBackground: textColor,
      outline: borderColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: transparent,
      foregroundColor: textColor,
      surfaceTintColor: transparent,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
      ),
      iconTheme: IconThemeData(color: textColor, size: 23),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        color: textColor,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.9,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.65,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.35,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 17,
        height: 1.28,
        letterSpacing: -0.2,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: 15,
        height: 1.3,
        letterSpacing: -0.1,
      ),
      bodySmall: TextStyle(
        color: subTitleTextColor,
        fontSize: 13,
        height: 1.3,
      ),
      labelLarge: TextStyle(
        color: textColor,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 0.5,
      space: 1,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xEBF7F7FA),
      surfaceTintColor: transparent,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xF2FFFFFF),
      surfaceTintColor: transparent,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      textStyle: const TextStyle(color: textColor, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: searchFieldColor,
      hintStyle: const TextStyle(color: Color(0xFF8E8E93), fontSize: 17),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 44),
        elevation: 0,
        foregroundColor: iosBlue,
        side: const BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: iosBlue,
      selectionColor: Color(0x333B82F6),
      selectionHandleColor: iosBlue,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
