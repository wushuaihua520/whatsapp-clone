import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';

class MyTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBgColor,
    splashFactory: InkRipple.splashFactory,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: actionGreen,
      onSecondary: blackColor,
      surface: scaffoldBgColor,
      onSurface: textColor,
      background: scaffoldBgColor,
      onBackground: textColor,
      outline: borderColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldBgColor,
      foregroundColor: textColor,
      surfaceTintColor: transparent,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: navigationBgColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      iconTheme: IconThemeData(color: textColor, size: 24),
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: textColor, fontSize: 16, height: 1.35),
      bodyMedium: TextStyle(color: textColor, fontSize: 14, height: 1.35),
      bodySmall: TextStyle(
        color: subTitleTextColor,
        fontSize: 12,
        height: 1.35,
      ),
      labelLarge: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 0.7,
      space: 1,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: transparent,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 72,
      backgroundColor: navigationBgColor,
      surfaceTintColor: transparent,
      indicatorColor: selectedNavColor,
      elevation: 0,
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        return TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: states.contains(MaterialState.selected)
              ? FontWeight.w600
              : FontWeight.w500,
        );
      }),
      iconTheme: MaterialStateProperty.resolveWith((states) {
        return const IconThemeData(color: textColor, size: 24);
      }),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      surfaceTintColor: transparent,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(color: textColor, fontSize: 15),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: searchFieldColor,
      hintStyle: const TextStyle(color: subTitleTextColor, fontSize: 15),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(28),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(28),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor, width: 1.4),
        borderRadius: BorderRadius.circular(28),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 42),
        elevation: 0,
        foregroundColor: primaryColor,
        side: const BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: actionGreen,
      foregroundColor: blackColor,
      elevation: 2,
      focusElevation: 3,
      hoverElevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(17)),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: selectedNavColor,
      selectionHandleColor: primaryColor,
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: primaryColor),
  );
}
