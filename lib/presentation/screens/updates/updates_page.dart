import 'package:flutter/material.dart';

import 'components/channels_list.dart';
import 'components/status_horizontal.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('updates-list'),
      padding: const EdgeInsets.only(bottom: 120),
      children: const [
        StatusHorizontal(),
        SizedBox(height: 18),
        ChannelsList(),
      ],
    );
  }
}
