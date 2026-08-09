import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
                icon: CupertinoIcons.plus,
                tooltip: '新动态',
                onPressed: () {},
              ),
              _IosChromeButton(
                icon: CupertinoIcons.camera,
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
                icon: CupertinoIcons.phone_badge_plus,
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
                icon: CupertinoIcons.plus,
                tooltip: '新社区',
                onPressed: () {},
              ),
            ],
            child: _pages[2],
          ),
          _IosTabPage(
            title: '聊天',
            leadingAction: _IosChromeButton(
              icon: CupertinoIcons.ellipsis,
              tooltip: '更多',
              onPressed: () {},
            ),
            actions: [
              _IosChromeButton(
                icon: CupertinoIcons.camera,
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
                      icon: CupertinoIcons.search,
                      tooltip: '搜索',
                      onPressed: () {},
                    ),
                    const Spacer(),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5EA),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          CupertinoButton(
                            padding: const EdgeInsets.all(8),
                            minSize: 0,
                            onPressed: () {},
                            child: const Icon(
                              CupertinoIcons.qrcode,
                              color: textColor,
                              size: 20,
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.all(8),
                            minSize: 0,
                            onPressed: () {},
                            child: const Icon(
                              CupertinoIcons.pencil,
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
    final button = CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 36,
      onPressed: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0xFFE5E5EA),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: textColor, size: 19),
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
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 36,
        onPressed: onPressed,
        child: Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFF25D366),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            CupertinoIcons.plus,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

/// Floating frosted tab bar — Cupertino icons, iOS Liquid Glass, no Material.
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
      icon: CupertinoIcons.circle,
      selectedIcon: CupertinoIcons.circle_fill,
    ),
    _IosTabDestination(
      label: '通话',
      icon: CupertinoIcons.phone,
      selectedIcon: CupertinoIcons.phone_fill,
    ),
    _IosTabDestination(
      label: '社区',
      icon: CupertinoIcons.person_3,
      selectedIcon: CupertinoIcons.person_3_fill,
    ),
    _IosTabDestination(
      label: '聊天',
      icon: CupertinoIcons.chat_bubble,
      selectedIcon: CupertinoIcons.chat_bubble_fill,
    ),
    _IosTabDestination(
      label: '自己',
      icon: CupertinoIcons.person,
      selectedIcon: CupertinoIcons.person_fill,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(14, 0, 14, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xCCF7F7F7),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: const Color(0x80FFFFFF),
                width: 0.5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
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
        ? (isProfile ? const Color(0xFF00A884) : textColor)
        : const Color(0xFF8E8E93);

    return CupertinoButton(
      key: Key('ios-tab-${destination.label}'),
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: selected ? (isProfile ? 40 : 48) : 40,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: !selected
                  ? Colors.transparent
                  : isProfile
                      ? const Color(0x3325D366)
                      : const Color(0x1A3C3C43),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              selected ? destination.selectedIcon : destination.icon,
              color: color,
              size: 23,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            destination.label,
            maxLines: 1,
            style: TextStyle(
              color: color,
              fontSize: 10,
              height: 1.1,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ),
        ],
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
