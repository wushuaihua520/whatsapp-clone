import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/routes/routes_name.dart';
import '../calls/call_logs.dart';
import '../../../utils/constants.dart';
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
            title: '更新',
            actions: [
              _IosChromeButton(
                icon: Icons.add_rounded,
                tooltip: '新动态',
                onPressed: () {},
              ),
              _IosChromeButton(
                icon: Icons.photo_camera_outlined,
                tooltip: '相机',
                onPressed: () {},
              ),
            ],
            child: _pages[0],
          ),
          _IosTabPage(
            title: '通话',
            actions: [
              _IosChromeButton(
                icon: Icons.add_call,
                tooltip: '新通话',
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.contactPage),
              ),
            ],
            child: _pages[1],
          ),
          _IosTabPage(
            title: '社区',
            actions: [
              _IosChromeButton(
                icon: Icons.add_rounded,
                tooltip: '新社区',
                onPressed: () {},
              ),
            ],
            child: _pages[2],
          ),
          _IosTabPage(
            title: '聊天',
            leadingAction: _IosChromeButton(
              icon: Icons.more_horiz_rounded,
              tooltip: '更多',
              onPressed: () {},
            ),
            actions: [
              _IosChromeButton(
                icon: Icons.photo_camera_outlined,
                tooltip: '相机',
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
          _IosProfileHeaderPage(child: _pages[4]),
        ],
      ),
      bottomNavigationBar: _IosWhatsAppTabBar(
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
  });

  final String? title;
  final Widget child;
  final List<Widget> actions;
  final Widget? leadingAction;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: scaffoldBgColor,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        if (leadingAction != null) leadingAction!,
                        const Spacer(),
                        for (var index = 0;
                            index < actions.length;
                            index++) ...[
                          actions[index],
                          if (index < actions.length - 1)
                            const SizedBox(width: 8),
                        ],
                      ],
                    ),
                  ),
                  if (title != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        child: Text(
                          title!,
                          key: Key('ios-$title-title'),
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 34,
                            height: 1.05,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Profile / 「自己」 header matching the reference: search circle + QR/edit pill.
class _IosProfileHeaderPage extends StatelessWidget {
  const _IosProfileHeaderPage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: iosGroupedBackground,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    _IosChromeButton(
                      icon: Icons.search_rounded,
                      tooltip: '搜索',
                      onPressed: () {},
                    ),
                    const Spacer(),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E8ED),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            tooltip: '二维码',
                            onPressed: () {},
                            constraints: const BoxConstraints.tightFor(
                              width: 36,
                              height: 36,
                            ),
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.qr_code_2_rounded,
                              color: textColor,
                              size: 20,
                            ),
                          ),
                          IconButton(
                            tooltip: '编辑',
                            onPressed: () {},
                            constraints: const BoxConstraints.tightFor(
                              width: 36,
                              height: 36,
                            ),
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: textColor,
                              size: 19,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _IosChromeButton extends StatelessWidget {
  const _IosChromeButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: const Color(0xFFE8E8ED),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: textColor, size: 20),
        ),
      ),
    );
    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
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
        color: const Color(0xFF25D366),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: const SizedBox(
            width: 36,
            height: 36,
            child: Icon(Icons.add_rounded, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }
}

/// Floating frosted tab bar matching Chinese WhatsApp iOS references.
class _IosWhatsAppTabBar extends StatelessWidget {
  const _IosWhatsAppTabBar({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _destinations = [
    _IosTabDestination(
      label: '更新',
      icon: Icons.donut_large_outlined,
      selectedIcon: Icons.donut_large,
    ),
    _IosTabDestination(
      label: '通话',
      icon: Icons.call_outlined,
      selectedIcon: Icons.call,
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
      label: '自己',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 0, 12, 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: Container(
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xF2F7F7F7),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0x66FFFFFF), width: 0.6),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 18,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
    final isProfile = destination.label == '自己';
    final color = selected
        ? (isProfile ? primaryColor : textColor)
        : const Color(0xFF8E8E93);

    return Semantics(
      selected: selected,
      button: true,
      label: destination.label,
      child: GestureDetector(
        key: Key('ios-tab-${destination.label}'),
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(
                horizontal: selected && !isProfile ? 12 : 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: !selected
                    ? Colors.transparent
                    : isProfile
                        ? const Color(0x3325D366)
                        : const Color(0x1F3C3C43),
                borderRadius: BorderRadius.circular(isProfile ? 20 : 14),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    selected ? destination.selectedIcon : destination.icon,
                    color: color,
                    size: 22,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              destination.label,
              maxLines: 1,
              style: TextStyle(
                color: color,
                fontSize: 10,
                height: 1,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
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
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
