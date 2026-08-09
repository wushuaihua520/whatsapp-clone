import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../calls/call_logs.dart';
import '../chats/controller/message_controller.dart';
import '../chats/participants_list.dart';
import '../community/community_page.dart';
import '../settings_page.dart';
import '../updates/updates_page.dart';
import '../../../utils/constants.dart';

/// WhatsApp iOS shell: Cupertino pages + floating Liquid Glass tab bar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 3;

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
    final bg = _index == 4 ? iosGroupedBackground : scaffoldBgColor;
    return ColoredBox(
      color: bg,
      child: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(
              index: _index,
              children: _pages,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _LiquidGlassTabBar(
              selectedIndex: _index,
              onSelected: (i) => setState(() => _index = i),
            ),
          ),
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

  static const _tabs = [
    (CupertinoIcons.arrow_2_circlepath, CupertinoIcons.arrow_2_circlepath, '更新'),
    (CupertinoIcons.phone, CupertinoIcons.phone_fill, '通话'),
    (CupertinoIcons.person_3, CupertinoIcons.person_3_fill, '社区'),
    (CupertinoIcons.chat_bubble, CupertinoIcons.chat_bubble_fill, '聊天'),
    (CupertinoIcons.person, CupertinoIcons.person_fill, '自己'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xD9F2F2F7),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0xB3FFFFFF), width: 0.7),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 24,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                for (var i = 0; i < _tabs.length; i++)
                  Expanded(
                    child: _TabItem(
                      icon: _tabs[i].$1,
                      activeIcon: _tabs[i].$2,
                      label: _tabs[i].$3,
                      selected: selectedIndex == i,
                      onTap: () => onSelected(i),
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

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isMe = label == '自己';
    final color = selected ? textColor : const Color(0xFF8E8E93);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: selected ? (isMe ? 36 : 46) : 36,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: !selected
                  ? const Color(0x00000000)
                  : isMe
                      ? const Color(0xFFB2EBE3)
                      : const Color(0x293C3C43),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(selected ? activeIcon : icon, color: color, size: 22),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
