import 'package:flutter/material.dart';

import 'presentation/core/routes/routes_name.dart';
import 'utils/strings.dart';
import 'widgets/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: KStrings.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: RouteNames.generateRoutes,
      theme: MyTheme.theme,
    );
  }
}
