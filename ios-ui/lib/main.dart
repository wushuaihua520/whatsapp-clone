import 'package:flutter/cupertino.dart';

import 'presentation/core/routes/routes_name.dart';
import 'utils/strings.dart';
import 'widgets/custom_theme.dart';
import 'widgets/iphone_device_frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: KStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.cupertino,
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: RouteNames.generateRoutes,
      builder: (context, child) {
        return IphoneExperience(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
