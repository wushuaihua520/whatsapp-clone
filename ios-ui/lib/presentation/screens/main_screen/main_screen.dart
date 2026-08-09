import 'package:flutter/cupertino.dart';

import '../../core/routes/routes_name.dart';
import '../calls/call_logs.dart';
import '../chats/controller/message_controller.dart';
import '../chats/participants_list.dart';
import '../community/community_page.dart';
import '../settings_page.dart';
import '../updates/updates_page.dart';
import '../../../utils/constants.dart';

/// Root shell built entirely with Cupertino tab navigation.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final CupertinoTabController _tabController;

  @override
  void initState() {
    MessageController.init();
    _tabController = CupertinoTabController(initialIndex: 3);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _tabController,
      backgroundColor: scaffoldBgColor,
      tabBar: CupertinoTabBar(
        backgroundColor: const Color(0xF2F7F7F7),
        border: const Border(
          top: BorderSide(color: Color(0x4D3C3C43), width: 0.33),
        ),
        activeColor: textColor,
        inactiveColor: CupertinoColors.inactiveGray,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.circle, key: Key('ios-tab-更新')),
            activeIcon: Icon(CupertinoIcons.circle_fill),
            label: '更新',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone, key: Key('ios-tab-通话')),
            activeIcon: Icon(CupertinoIcons.phone_fill),
            label: '通话',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_3, key: Key('ios-tab-社区')),
            activeIcon: Icon(CupertinoIcons.person_3_fill),
            label: '社区',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble, key: Key('ios-tab-聊天')),
            activeIcon: Icon(CupertinoIcons.chat_bubble_fill),
            label: '聊天',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person, key: Key('ios-tab-自己')),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: '自己',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (_) => const UpdatesPage(),
              onGenerateRoute: RouteNames.generateRoutes,
            );
          case 1:
            return CupertinoTabView(
              builder: (_) => const CallLogs(),
              onGenerateRoute: RouteNames.generateRoutes,
            );
          case 2:
            return CupertinoTabView(
              builder: (_) => const CommunityPage(),
              onGenerateRoute: RouteNames.generateRoutes,
            );
          case 3:
            return CupertinoTabView(
              builder: (_) => const ConversationList(),
              onGenerateRoute: RouteNames.generateRoutes,
            );
          case 4:
          default:
            return CupertinoTabView(
              builder: (_) => const SettingsPage(),
              onGenerateRoute: RouteNames.generateRoutes,
            );
        }
      },
    );
  }
}
