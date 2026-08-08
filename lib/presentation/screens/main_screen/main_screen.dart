import 'package:flutter/material.dart';

import '../../core/routes/routes_name.dart';
import '../calls/call_logs.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../chats/controller/message_controller.dart';
import '../chats/participants_list.dart';
import '../community/community_page.dart';
import '../updates/updates_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedTab = 0;

  static const _pages = <Widget>[
    ConversationList(),
    UpdatesPage(),
    CommunityPage(),
    CallLogs(),
  ];

  @override
  void initState() {
    MessageController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: IndexedStack(index: selectedTab, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() => selectedTab = index);
        },
        destinations: [
          NavigationDestination(
            icon: _navIcon(Icons.chat_bubble_outline_rounded, showBadge: true),
            selectedIcon: _navIcon(Icons.chat_bubble_rounded, showBadge: true),
            label: 'Chats',
          ),
          const NavigationDestination(
            icon: Icon(Icons.update_outlined),
            selectedIcon: Icon(Icons.update_rounded),
            label: 'Updates',
          ),
          const NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Communities',
          ),
          const NavigationDestination(
            icon: Icon(Icons.call_outlined),
            selectedIcon: Icon(Icons.call_rounded),
            label: 'Calls',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: _buildFloatingActions(),
      ),
    );
  }

  AppBar _buildAppBar() {
    const titles = ['WhatsApp', 'Updates', 'Communities', 'Calls'];
    return AppBar(
      toolbarHeight: 64,
      titleSpacing: 20,
      title: Text(
        titles[selectedTab],
        style: TextStyle(
          color: selectedTab == 0 ? primaryColor : textColor,
          fontSize: selectedTab == 0 ? 26 : 22,
          fontWeight: FontWeight.w600,
          letterSpacing: selectedTab == 0 ? -0.8 : -0.3,
        ),
      ),
      actions: _buildTopActions(),
    );
  }

  List<Widget> _buildTopActions() {
    final actions = <Widget>[];

    if (selectedTab == 0) {
      actions.add(
        IconButton(
          tooltip: 'Linked devices',
          onPressed: () => _showMessage('QR scanner'),
          icon: const Icon(Icons.qr_code_scanner_rounded),
        ),
      );
    }

    if (selectedTab == 0 || selectedTab == 1) {
      actions.add(
        const IconButton(
          tooltip: 'Camera',
          onPressed: Utils.openCamera,
          icon: Icon(Icons.photo_camera_outlined),
        ),
      );
    }

    if (selectedTab == 1 || selectedTab == 3) {
      actions.add(
        IconButton(
          tooltip: 'Search',
          onPressed: () => _showMessage('Search'),
          icon: const Icon(Icons.search_rounded),
        ),
      );
    }

    actions.add(
      PopupMenuButton<String>(
        tooltip: 'More options',
        icon: const Icon(Icons.more_vert_rounded),
        offset: const Offset(0, 52),
        onSelected: _showMessage,
        itemBuilder: (context) {
          return _menuItems
              .map(
                (item) => PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList();
        },
      ),
    );

    actions.add(const SizedBox(width: 6));
    return actions;
  }

  List<String> get _menuItems {
    switch (selectedTab) {
      case 1:
        return const ['Status privacy', 'Create channel', 'Settings'];
      case 2:
        return const ['New community', 'Settings'];
      case 3:
        return const ['Clear call log', 'Settings'];
      default:
        return const [
          'New group',
          'New broadcast',
          'Linked devices',
          'Starred messages',
          'Settings',
        ];
    }
  }

  Widget _buildFloatingActions() {
    switch (selectedTab) {
      case 0:
        return Column(
          key: const ValueKey('chat-actions'),
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.small(
              heroTag: 'meta-ai',
              tooltip: 'Meta AI',
              backgroundColor: Colors.white,
              foregroundColor: primaryColor,
              onPressed: () => _showMessage('Meta AI'),
              shape: const CircleBorder(),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF635BFF), Color(0xFF00AEEF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child:
                    const Icon(Icons.auto_awesome_rounded, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: 'new-chat',
              tooltip: 'New chat',
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.contactPage),
              child: const Icon(Icons.add_comment_rounded),
            ),
          ],
        );
      case 1:
        return Column(
          key: const ValueKey('update-actions'),
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.small(
              heroTag: 'text-status',
              tooltip: 'Text status',
              backgroundColor: Colors.white,
              foregroundColor: textColor,
              onPressed: () => _showMessage('Create text status'),
              child: const Icon(Icons.edit_rounded),
            ),
            const SizedBox(height: 12),
            const FloatingActionButton(
              heroTag: 'camera-status',
              tooltip: 'Camera status',
              onPressed: Utils.openCamera,
              child: Icon(Icons.photo_camera_rounded),
            ),
          ],
        );
      case 3:
        return FloatingActionButton(
          key: const ValueKey('call-action'),
          heroTag: 'new-call',
          tooltip: 'New call',
          onPressed: () => Navigator.pushNamed(context, RouteNames.contactPage),
          child: const Icon(Icons.add_call),
        );
      default:
        return const SizedBox(key: ValueKey('no-action'));
    }
  }

  Widget _navIcon(IconData icon, {bool showBadge = false}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon),
        if (showBadge)
          Positioned(
            right: -7,
            top: -5,
            child: Container(
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                color: actionGreen,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                '6',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$message selected'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
