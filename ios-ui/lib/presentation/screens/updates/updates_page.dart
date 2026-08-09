import 'package:flutter/cupertino.dart';

import 'components/channels_list.dart';
import 'components/status_horizontal.dart';
import '../../../utils/constants.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: scaffoldBgColor,
      child: CustomScrollView(
        key: const PageStorageKey('updates-list'),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('更新', key: Key('ios-更新-title')),
            backgroundColor: const Color(0xF7F9F9F9),
            border: null,
            transitionBetweenRoutes: false,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.only(right: 8),
                  minSize: 0,
                  onPressed: () {},
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5E5EA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(CupertinoIcons.ellipsis, size: 18),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: () {},
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFF25D366),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.plus,
                      color: CupertinoColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: StatusHorizontal()),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),
          const SliverToBoxAdapter(child: ChannelsList()),
          const SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
    );
  }
}
