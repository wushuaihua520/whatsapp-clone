import 'package:flutter/cupertino.dart';
import 'package:whatsapp_ios_ui/presentation/screens/auth/auth_page.dart';

import '../../screens/auth/welcome_screen.dart';
import '../../screens/contact/contact_page.dart';
import '../../screens/chats/inbox.dart';
import '../../screens/chats/contact_info_page.dart';
import '../../screens/updates/story_view.dart';
import '../../screens/main_screen/main_screen.dart';
import '../../screens/splash_screen.dart';

class RouteNames {
  static const String splashScreen = '/s';
  static const String mainScreen = '/mainScreen';
  static const String inbox = '/inbox';
  static const String contactInfo = '/contactInfo';
  static const String storyPage = '/storyPage';
  static const String contactPage = '/contact';
  static const String welcome = '/welcome';
  static const String auth = '/auth';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
      case RouteNames.mainScreen:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const MainScreen(),
        );
      case RouteNames.inbox:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const Inbox(),
        );
      case RouteNames.contactInfo:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const ContactInfoPage(),
        );
      case RouteNames.storyPage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => MyStoryPage(),
        );
      case RouteNames.contactPage:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const ContactPage(),
        );
      case RouteNames.welcome:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const WelcomeScreen(),
        );
      case RouteNames.auth:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const AuthPage(),
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('路由错误'),
            ),
            child: Center(
              child: Text('No Route Found ${settings.name}'),
            ),
          ),
        );
    }
  }
}
