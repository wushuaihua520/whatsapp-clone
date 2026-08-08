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
          'Favorites',
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
          'Recent',
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
      color: searchFieldColor,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: actionGreen,
                child: Icon(Icons.link_rounded, color: blackColor, size: 25),
              ),
              SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create call link',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Share a link for your WhatsApp call',
                      style: TextStyle(
                        color: subTitleTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: subTitleTextColor),
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
            color: searchFieldColor,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {},
              child: const SizedBox(
                width: 54,
                height: 54,
                child: Icon(Icons.add_rounded, color: primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add',
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
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: callLogs.isMissed ? const Color(0xFFD93025) : textColor,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            callLogs.incoming ? Icons.call_received : Icons.call_made,
            size: 17,
            color: callLogs.isMissed ? const Color(0xFFD93025) : primaryColor,
          ),
          const SizedBox(width: 5),
          Text(
            callLogs.time,
            style: const TextStyle(
              color: subTitleTextColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        tooltip: isVideo ? 'Video call' : 'Voice call',
        onPressed: () {},
        icon: Icon(
          isVideo ? Icons.videocam_outlined : Icons.call_outlined,
          color: primaryColor,
        ),
      ),
    );
  }
}
