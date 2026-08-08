import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/dummy_data.dart';
import '../../../../data/model/channel_news_model.dart';
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
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Channels',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: hTextColor,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                tooltip: 'Channel options',
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.add_rounded, color: textColor),
                offset: const Offset(0, 35),
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'Find channels',
                    child: Text('Find channels'),
                  ),
                  PopupMenuItem(
                    value: 'Create channel',
                    child: Text('Create channel'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            'Stay updated on topics that matter to you.',
            style: TextStyle(color: subTitleTextColor, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: scaffoldBgColor,
              border: Border.all(color: dividerColor),
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (var index = 0;
                    index < KDummyData.channelNews.length;
                    index++) ...[
                  ChannelCard(news: KDummyData.channelNews[index]),
                  if (index != KDummyData.channelNews.length - 1)
                    const Divider(indent: 72),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.explore_outlined, size: 19),
            label: const Text('Explore more channels'),
          ),
        ],
      ),
    );
  }
}

class ChannelCard extends StatelessWidget {
  const ChannelCard({
    super.key,
    required this.news,
  });

  final ChannelNews news;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(news.date);
    final time = date == null ? '' : DateFormat.jm().format(date);

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: searchFieldColor,
                  backgroundImage: AssetImage(news.avatar),
                ),
                Positioned(
                  right: -1,
                  bottom: -1,
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.channelName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: hTextColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    news.news,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: subTitleTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color:
                        news.unread == null ? subTitleTextColor : primaryColor,
                    fontSize: 11,
                    fontWeight:
                        news.unread == null ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                if (news.unread != null)
                  Container(
                    width: 19,
                    height: 19,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: actionGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      news.unread!,
                      style: const TextStyle(
                        color: blackColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 19),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
