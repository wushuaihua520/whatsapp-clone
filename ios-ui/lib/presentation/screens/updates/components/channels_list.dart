import 'package:flutter/cupertino.dart';

import '../../../../data/dummy_data.dart';
import '../../../../utils/constants.dart';

class ChannelsList extends StatelessWidget {
  const ChannelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '频道',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            '及时了解你关心的话题。',
            style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 13),
          ),
          const SizedBox(height: 12),
          CupertinoListSection.insetGrouped(
            margin: EdgeInsets.zero,
            children: [
              for (final news in KDummyData.channelNews)
                CupertinoListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: searchFieldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(CupertinoIcons.collections),
                  ),
                  title: Text(news.channelName),
                  subtitle: Text(
                    news.news,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: const Text(
              '探索更多频道',
              style: TextStyle(color: iosBlue),
            ),
          ),
        ],
      ),
    );
  }
}
