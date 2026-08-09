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
            title: 'Updates',
            actions: [
              GlassCircleButton(
                icon: Icons.add_rounded,
                tooltip: 'New update',
                onPressed: () {},
              ),
              GlassCircleButton(
                icon: Icons.photo_camera_outlined,
                tooltip: 'Camera',
                onPressed: () {},
              ),
            ],
            child: _pages[0],
          ),
          _IosTabPage(
            title: 'Calls',
            leadingLabel: 'Edit',
            actions: [
              GlassCircleButton(
                icon: Icons.add_call,
                tooltip: 'New call',
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.contactPage),
              ),
            ],
            child: _pages[1],
          ),
          _IosTabPage(
            title: 'Communities',
            actions: [
              GlassCircleButton(
                icon: Icons.add_rounded,
                tooltip: 'New community',
                onPressed: () {},
              ),
            ],
            child: _pages[2],
          ),
          _IosTabPage(
            title: 'Chats',
            leadingLabel: 'Edit',
            actions: [
              GlassCircleButton(
                icon: Icons.photo_camera_outlined,
                tooltip: 'Camera',
                onPressed: () {},
              ),
              GlassCircleButton(
                icon: Icons.edit_rounded,
                tooltip: 'New chat',
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.contactPage),
              ),
            ],
            child: _pages[3],
          ),
          _IosTabPage(
            title: 'Settings',
            backgroundColor: iosGroupedBackground,
            actions: [
              GlassCircleButton(
                icon: Icons.qr_code_rounded,
                tooltip: 'QR code',
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
    required this.title,
    required this.child,
    this.actions = const [],
    this.leadingLabel,
    this.backgroundColor = scaffoldBgColor,
  });

  final String title;
  final Widget child;
  final List<Widget> actions;
  final String? leadingLabel;
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
                        if (leadingLabel != null)
                          TextButton(
                            key: Key('ios-$title-leading-action'),
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: iosBlue,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(44, 38),
                              alignment: Alignment.centerLeft,
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            child: Text(leadingLabel!),
                          ),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      key: Key('ios-$title-title'),
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 34,
                        height: 1.05,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.9,
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

class _LiquidGlassTabBar extends StatelessWidget {
  const _LiquidGlassTabBar({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _destinations = [
    _IosTabDestination(
      label: 'Updates',
      icon: Icons.update_outlined,
      selectedIcon: Icons.update_rounded,
    ),
    _IosTabDestination(
      label: 'Calls',
      icon: Icons.call_outlined,
      selectedIcon: Icons.call_rounded,
    ),
    _IosTabDestination(
      label: 'Communities',
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups_rounded,
    ),
    _IosTabDestination(
      label: 'Chats',
      icon: Icons.chat_bubble_outline_rounded,
      selectedIcon: Icons.chat_bubble_rounded,
      badge: 6,
    ),
    _IosTabDestination(
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
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
    final color = selected ? iosBlue : iosSecondaryLabel;
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
              color: selected ? const Color(0x73FFFFFF) : Colors.transparent,
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
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF3B30),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            destination.badge.toString(),
                            style: const TextStyle(
                              color: Colors.white,
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
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final int? badge;
}
