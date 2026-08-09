import 'package:flutter/material.dart';

import '../../core/routes/routes_name.dart';
import '../calls/call_logs.dart';
import '../../../utils/constants.dart';
import '../../../widgets/glass_surface.dart';
import '../chats/controller/message_controller.dart';
import '../chats/participants_list.dart';
import '../community/community_page.dart';
import '../settings_page.dart';
import '../updates/updates_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedTab = 3;

  static const _pages = <Widget>[
    UpdatesPage(),
    CallLogs(),
    CommunityPage(),
    ConversationList(),
    SettingsPage(),
  ];

  @override
  void initState() {
    MessageController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          selectedTab == 4 ? iosGroupedBackground : scaffoldBgColor,
      extendBody: true,
      body: IndexedStack(
        index: selectedTab,
        children: [
          _IosTabPage(
            title: '动态',
            actions: [
              GlassCircleButton(
                icon: Icons.add_rounded,
                tooltip: '新动态',
                size: 38,
                iconColor: textColor,
                onPressed: () {},
              ),
              GlassCircleButton(
                icon: Icons.photo_camera_outlined,
                tooltip: '相机',
                size: 38,
                iconColor: textColor,
                onPressed: () {},
              ),
            ],
            child: _pages[0],
          ),
          _IosTabPage(
            title: '通话',
            actions: [
              GlassCircleButton(
                icon: Icons.add_call,
                tooltip: '新通话',
                size: 38,
                iconColor: textColor,
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.contactPage),
              ),
            ],
            child: _pages[1],
          ),
          _IosTabPage(
            title: '社区',
            actions: [
              GlassCircleButton(
                icon: Icons.add_rounded,
                tooltip: '新社区',
                size: 38,
                iconColor: textColor,
                onPressed: () {},
              ),
            ],
            child: _pages[2],
          ),
          _IosTabPage(
            title: '聊天',
            leadingAction: GlassCircleButton(
              icon: Icons.more_horiz_rounded,
              tooltip: '更多',
              size: 38,
              iconColor: textColor,
              onPressed: () {},
            ),
            actions: [
              GlassCircleButton(
                icon: Icons.photo_camera_outlined,
                tooltip: '相机',
                size: 38,
                iconColor: textColor,
                onPressed: () {},
              ),
              _GreenCircleButton(
                tooltip: '新聊天',
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.contactPage),
              ),
            ],
            child: _pages[3],
          ),
          _IosTabPage(
            leadingAction: GlassCircleButton(
              icon: Icons.search_rounded,
              tooltip: '搜索',
              size: 38,
              iconColor: textColor,
              onPressed: () {},
            ),
            backgroundColor: iosGroupedBackground,
            actions: [
              GlassCircleButton(
                icon: Icons.qr_code_rounded,
                tooltip: '二维码',
                size: 38,
                iconColor: textColor,
                onPressed: () {},
              ),
              GlassCircleButton(
                icon: Icons.edit_rounded,
                tooltip: '编辑',
                size: 38,
                iconColor: textColor,
                onPressed: () {},
              ),
            ],
            child: _pages[4],
          ),
        ],
      ),
      bottomNavigationBar: _LiquidGlassTabBar(
        selectedIndex: selectedTab,
        onSelected: (index) => setState(() => selectedTab = index),
      ),
    );
  }
}

class _IosTabPage extends StatelessWidget {
  const _IosTabPage({
    required this.child,
    this.actions = const [],
    this.title,
    this.leadingAction,
    this.backgroundColor = scaffoldBgColor,
  });

  final String? title;
  final Widget child;
  final List<Widget> actions;
  final Widget? leadingAction;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 7, 16, 3),
              child: Column(
                children: [
                  SizedBox(
                    height: 42,
                    child: Row(
                      children: [
                        if (leadingAction != null) leadingAction!,
                        const Spacer(),
                        for (var index = 0;
                            index < actions.length;
                            index++) ...[
                          actions[index],
                          if (index < actions.length - 1)
                            const SizedBox(width: 9),
                        ],
                      ],
                    ),
                  ),
                  if (title != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title!,
                        key: Key('ios-$title-title'),
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 29,
                          height: 1.08,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.7,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 7),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _GreenCircleButton extends StatelessWidget {
  const _GreenCircleButton({
    required this.onPressed,
    required this.tooltip,
  });

  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: const Color(0xFF20C56D),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: const SizedBox(
            width: 38,
            height: 38,
            child: Icon(Icons.add_rounded, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}

class _LiquidGlassTabBar extends StatelessWidget {
  const _LiquidGlassTabBar({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _destinations = [
    _IosTabDestination(
      label: '动态',
      icon: Icons.update_outlined,
      selectedIcon: Icons.update_rounded,
    ),
    _IosTabDestination(
      label: '通话',
      icon: Icons.call_outlined,
      selectedIcon: Icons.call_rounded,
    ),
    _IosTabDestination(
      label: '社区',
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups_rounded,
    ),
    _IosTabDestination(
      label: '聊天',
      icon: Icons.chat_bubble_outline_rounded,
      selectedIcon: Icons.chat_bubble_rounded,
    ),
    _IosTabDestination(
      label: '设置',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
      badge: 1,
      badgeColor: selectedNavColor,
      badgeTextColor: primaryColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(10, 0, 10, 7),
      child: GlassSurface(
        borderRadius: 34,
        blur: 30,
        opacity: 0.67,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: SizedBox(
          height: 62,
          child: Row(
            children: [
              for (var index = 0; index < _destinations.length; index++)
                Expanded(
                  child: _IosTabButton(
                    destination: _destinations[index],
                    selected: selectedIndex == index,
                    onTap: () => onSelected(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IosTabButton extends StatelessWidget {
  const _IosTabButton({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final _IosTabDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSettings = destination.label == '设置';
    final color =
        selected ? (isSettings ? primaryColor : textColor) : iosSecondaryLabel;
    final selectedBackground =
        isSettings ? const Color(0x80D9FDD3) : const Color(0x247A7A7A);
    return Semantics(
      selected: selected,
      button: true,
      label: destination.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: Key('ios-tab-${destination.label}'),
          borderRadius: BorderRadius.circular(27),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: selected ? selectedBackground : Colors.transparent,
              borderRadius: BorderRadius.circular(27),
              border: selected
                  ? Border.all(color: const Color(0x99FFFFFF), width: 0.7)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      selected ? destination.selectedIcon : destination.icon,
                      color: color,
                      size: 23,
                    ),
                    if (destination.badge != null)
                      Positioned(
                        right: -10,
                        top: -7,
                        child: Container(
                          constraints:
                              const BoxConstraints(minWidth: 17, minHeight: 17),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: destination.badgeColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            destination.badge.toString(),
                            style: TextStyle(
                              color: destination.badgeTextColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  destination.label,
                  maxLines: 1,
                  style: TextStyle(
                    color: color,
                    fontSize: 9.5,
                    height: 1,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IosTabDestination {
  const _IosTabDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.badge,
    this.badgeColor = const Color(0xFFFF3B30),
    this.badgeTextColor = Colors.white,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final int? badge;
  final Color badgeColor;
  final Color badgeTextColor;
}
