import 'package:flutter/material.dart';

import '../../../data/dummy_data.dart';
import '../../../utils/constants.dart';
import '../../../data/model/call_log_model.dart';

class CallLogs extends StatelessWidget {
  const CallLogs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('calls-list'),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 108),
      children: [
        const _CreateCallLink(),
        const SizedBox(height: 22),
        const Text(
          '特别关注',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        const _FavoriteContacts(),
        const SizedBox(height: 24),
        const Text(
          '最近',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        ...KDummyData.callHistory.map((call) => CallCard(callLogs: call)),
      ],
    );
  }
}

class _CreateCallLink extends StatelessWidget {
  const _CreateCallLink();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFE5E5EA),
                child: Icon(Icons.link_rounded, color: primaryColor, size: 22),
              ),
              SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '创建通话链接',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '分享链接，邀请他人加入 WhatsApp 通话',
                      style: TextStyle(
                        color: iosSecondaryLabel,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteContacts extends StatelessWidget {
  const _FavoriteContacts();

  @override
  Widget build(BuildContext context) {
    final contacts = KDummyData.contacts.take(4).toList();
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: contacts.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          if (index == contacts.length) {
            return const _AddFavorite();
          }
          final contact = contacts[index];
          return SizedBox(
            width: 62,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor: searchFieldColor,
                  backgroundImage: AssetImage(contact['avatar']!),
                ),
                const SizedBox(height: 6),
                Text(
                  contact['user']!.split(' ').first,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: textColor, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AddFavorite extends StatelessWidget {
  const _AddFavorite();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      child: Column(
        children: [
          Material(
            color: const Color(0xFFF2F2F7),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {},
              child: const SizedBox(
                width: 54,
                height: 54,
                child: Icon(Icons.add_rounded, color: iosBlue),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '添加',
            style: TextStyle(color: textColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class CallCard extends StatelessWidget {
  const CallCard({
    super.key,
    required this.callLogs,
  });
  final CallLog callLogs;

  @override
  Widget build(BuildContext context) {
    final isVideo = callLogs.callType.toLowerCase() == 'video';
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      leading: CircleAvatar(
        radius: 27,
        backgroundColor: searchFieldColor,
        backgroundImage: AssetImage(callLogs.avatar),
      ),
      title: Text(
        callLogs.personName,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: callLogs.isMissed ? const Color(0xFFFF3B30) : textColor,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            callLogs.incoming ? Icons.call_received : Icons.call_made,
            size: 16,
            color: callLogs.isMissed ? const Color(0xFFFF3B30) : primaryColor,
          ),
          const SizedBox(width: 5),
          Text(
            callLogs.time,
            style: const TextStyle(
              color: iosSecondaryLabel,
              fontSize: 14,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        tooltip: isVideo ? '视频通话' : '语音通话',
        onPressed: () {},
        icon: Icon(
          isVideo ? Icons.videocam_outlined : Icons.call_outlined,
          color: iosBlue,
        ),
      ),
    );
  }
}
