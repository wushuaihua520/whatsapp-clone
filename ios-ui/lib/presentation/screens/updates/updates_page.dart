import 'package:flutter/cupertino.dart';

import 'components/channels_list.dart';
import 'components/status_horizontal.dart';
import '../../../utils/constants.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: scaffoldBgColor,
      child: CustomScrollView(
        key: PageStorageKey('updates-list'),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('更新', key: Key('ios-更新-title')),
            backgroundColor: Color(0xF7F9F9F9),
            border: null,
          ),
          SliverToBoxAdapter(child: StatusHorizontal()),
          SliverToBoxAdapter(child: SizedBox(height: 18)),
          SliverToBoxAdapter(child: ChannelsList()),
          SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
