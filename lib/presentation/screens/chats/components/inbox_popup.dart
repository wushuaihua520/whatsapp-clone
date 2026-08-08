import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class InboxPopup extends StatelessWidget {
  const InboxPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'More options',
      icon: const Icon(Icons.more_vert_rounded, color: textColor),
      offset: const Offset(0, 50),
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        return const <PopupMenuEntry>[
          PopupMenuItem(
            child: Text('View contact'),
          ),
          PopupMenuItem(
            child: Text('Media, links, and docs'),
          ),
          PopupMenuItem(
            child: Text('Search'),
          ),
          PopupMenuItem(
            child: Text('Disappearing messages'),
          ),
          PopupMenuItem(
            child: Text('Wallpaper'),
          ),
          PopupMenuItem(
            child: Text('More'),
          ),
        ];
      },
    );
  }
}
