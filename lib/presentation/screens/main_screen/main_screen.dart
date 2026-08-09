import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';
import '../../../widgets/ios_glass.dart';
import '../../core/routes/routes_name.dart';
import '../calls/call_logs.dart';
import '../chats/controller/message_controller.dart';
import '../chats/participants_list.dart';
import '../community/community_page.dart';
import '../profile/profile_page.dart';
import '../updates/updates_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 3; // 聊天

  final _pages = const [
    UpdatesPage(),
    CallLogs(),
    CommunityPage(),
    ConversationList(),
    ProfilePage(),
  ];

  @override
  void initState() {
    MessageController.init();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tab = Uri.base.queryParameters['tab'];
      if (tab != null) {
        final i = int.tryParse(tab);
        if (i != null && i >= 0 && i < _pages.length) {
          setState(() => _selectedIndex = i);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final isProfile = _selectedIndex == 4;
    return Scaffold(
      backgroundColor: isProfile ? settingsBgColor : scaffoldBgColor,
      // Let body paint under the glass tab bar so blur is visible.
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _IosTabBar(
        selectedIndex: _selectedIndex,
        bottomInset: bottomInset,
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
      floatingActionButton: (_selectedIndex == 1 || _selectedIndex == 0)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.contactPage);
              },
              backgroundColor: primaryColor,
              elevation: 2,
              child: Icon(
                _selectedIndex == 1
                    ? CupertinoIcons.phone_fill
                    : CupertinoIcons.camera_fill,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}

class _IosTabBar extends StatelessWidget {
  const _IosTabBar({
    required this.selectedIndex,
    required this.onTap,
    required this.bottomInset,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final isProfile = selectedIndex == 4;
    if (isProfile) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          0,
          16,
          bottomInset > 0 ? bottomInset : 10,
        ),
        child: _FloatingTabBar(
          selectedIndex: selectedIndex,
          onTap: onTap,
        ),
      );
    }

    return IosGlass(
      sigma: 40,
      tint: const Color(0x99F2F2F7),
      border: Border(
        top: BorderSide(
          color: Colors.white.withValues(alpha: 0.55),
          width: 0.6,
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 54.h,
          child: Row(
            children: List.generate(5, (i) {
              return Expanded(
                child: _TabItem(
                  index: i,
                  selected: selectedIndex == i,
                  floating: false,
                  onTap: () => onTap(i),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _FloatingTabBar extends StatelessWidget {
  const _FloatingTabBar({
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return IosGlass(
      sigma: 40,
      tint: const Color(0xA8FFFFFF),
      frostImage: null,
      borderRadius: BorderRadius.circular(28),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.7),
        width: 0.9,
      ),
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 28,
          offset: const Offset(0, 10),
        ),
      ],
      child: SizedBox(
        height: 64,
        child: Row(
          children: List.generate(5, (i) {
            return Expanded(
              child: _TabItem(
                index: i,
                selected: selectedIndex == i,
                floating: true,
                onTap: () => onTap(i),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.index,
    required this.selected,
    required this.onTap,
    required this.floating,
  });

  final int index;
  final bool selected;
  final VoidCallback onTap;
  final bool floating;

  static const _labels = [
    '更新',
    '通话',
    '社群',
    '聊天',
    '自己',
  ];

  IconData _icon(bool filled) {
    switch (index) {
      case 0:
        return CupertinoIcons.arrow_2_circlepath;
      case 1:
        return filled ? CupertinoIcons.phone_fill : CupertinoIcons.phone;
      case 2:
        return filled
            ? CupertinoIcons.person_3_fill
            : CupertinoIcons.person_3;
      case 3:
        return filled
            ? CupertinoIcons.chat_bubble_fill
            : CupertinoIcons.chat_bubble;
      case 4:
        return filled
            ? CupertinoIcons.person_crop_circle_fill
            : CupertinoIcons.person_crop_circle;
      default:
        return CupertinoIcons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF1C1C1E);
    const inactiveColor = Color(0xFF8E8E93);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(
              horizontal: floating ? 12 : 14,
              vertical: floating ? 6 : 4,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? (floating ? accentMint : const Color(0xFF3A3A3C))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              _icon(selected),
              size: 22,
              color: selected
                  ? (floating ? const Color(0xFF1C1C1E) : Colors.white)
                  : inactiveColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _labels[index],
            style: TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              color: selected ? activeColor : inactiveColor,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
