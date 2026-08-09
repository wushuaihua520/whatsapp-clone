import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../data/dummy_data.dart';
import '../../../data/model/participants_chat_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/glass_surface.dart';
import 'components/input_text_emoji.dart';
import 'components/message_item.dart';
import 'controller/message_controller.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = KDummyData.participantsChat;

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(decoration: _decoration()),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top + 64),
                  Expanded(
                    child: StreamBuilder<List<Messages>>(
                      stream: MessageController.streamData,
                      initialData: MessageController.list,
                      builder: (context, snapshot) {
                        final messages = snapshot.data ?? user.messages;
                        if (messages.isEmpty) {
                          return const SizedBox();
                        }
                        return GroupedListView<Messages, DateTime>(
                          padding: const EdgeInsets.fromLTRB(10, 12, 10, 92),
                          elements: messages.toList(),
                          groupBy: (element) => DateTime(
                            element.date.year,
                            element.date.month,
                            element.date.day,
                          ),
                          groupSeparatorBuilder: (groupByValue) =>
                              MessageSeparator(groupByValue: groupByValue),
                          itemBuilder: (context, element) =>
                              MessageComponent(element: element),
                          itemComparator: (item1, item2) =>
                              item1.date.compareTo(item2.date),
                          useStickyGroupSeparators: false,
                          floatingHeader: true,
                          order: GroupedListOrder.ASC,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _GlassChatHeader(user: user),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: TextEmojiInputField(),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return const BoxDecoration(
      color: Color(0xFFF1EEE8),
      image: DecorationImage(
        image: AssetImage(KImages.defaultWallpaper),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Color(0x3DFFFFFF),
          BlendMode.srcATop,
        ),
      ),
    );
  }
}

class _GlassChatHeader extends StatelessWidget {
  const _GlassChatHeader({required this.user});

  final ParticipantsChat user;

  @override
  Widget build(BuildContext context) {
    return GlassSurface(
      borderRadius: 0,
      blur: 28,
      opacity: 0.68,
      boxShadow: false,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: [
              IconButton(
                key: const Key('ios-chat-back'),
                tooltip: 'Back',
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: iosBlue,
                  size: 34,
                ),
              ),
              CircleAvatar(
                radius: 19,
                backgroundImage: AssetImage(user.avatar),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.participant,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      user.status,
                      style: const TextStyle(
                        color: iosSecondaryLabel,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Video call',
                onPressed: () {},
                icon: const Icon(
                  Icons.videocam_outlined,
                  color: iosBlue,
                  size: 23,
                ),
              ),
              IconButton(
                tooltip: 'Voice call',
                onPressed: () {},
                icon: const Icon(
                  Icons.call_outlined,
                  color: iosBlue,
                  size: 21,
                ),
              ),
              IconButton(
                tooltip: 'More',
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: iosBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 2),
            ],
          ),
        ),
      ),
    );
  }
}
