import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../../data/dummy_data.dart';
import '../../../data/model/participants_chat_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../core/routes/routes_name.dart';
import 'components/input_text_emoji.dart';
import 'components/message_item.dart';
import 'controller/message_controller.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = KDummyData.participantsChat;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF1EEE8),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xCCF7F7F7),
        border: null,
        leading: CupertinoButton(
          key: const Key('ios-chat-back'),
          padding: EdgeInsets.zero,
          minSize: 0,
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(CupertinoIcons.back, size: 28),
        ),
        middle: CupertinoButton(
          key: const Key('ios-chat-avatar'),
          padding: EdgeInsets.zero,
          minSize: 0,
          onPressed: () =>
              Navigator.of(context).pushNamed(RouteNames.contactInfo),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4E7C9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.person_fill,
                  color: Color(0xFFB78032),
                  size: 18,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  user.participant,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.only(right: 2),
              minSize: 0,
              onPressed: () {},
              child: const Icon(CupertinoIcons.videocam, size: 26),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: () {},
              child: const Icon(CupertinoIcons.phone, size: 24),
            ),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              KImages.defaultWallpaper,
              fit: BoxFit.cover,
              color: const Color(0x2BFFFFFF),
              colorBlendMode: BlendMode.srcATop,
              errorBuilder: (_, __, ___) =>
                  const ColoredBox(color: Color(0xFFF1EEE8)),
            ),
          ),
          Positioned.fill(
            child: StreamBuilder<List<Messages>>(
              stream: MessageController.streamData,
              initialData: MessageController.list,
              builder: (context, snapshot) {
                final messages = snapshot.data ?? user.messages;
                final sorted = messages.toList()
                  ..sort((a, b) => a.date.compareTo(b.date));
                return ListView(
                  padding: EdgeInsets.fromLTRB(
                    10,
                    8,
                    10,
                    MediaQuery.of(context).padding.bottom + 72,
                  ),
                  children: [
                    const _ConversationDate(),
                    const _EncryptionNotice(),
                    const SizedBox(height: 8),
                    ...sorted.map(
                      (message) => MessageComponent(element: message),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            right: 12,
            bottom: MediaQuery.of(context).padding.bottom + 66,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: CupertinoButton(
                  key: const Key('ios-jump-to-latest'),
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  color: const Color(0x99FFFFFF),
                  borderRadius: BorderRadius.circular(18),
                  onPressed: () {},
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      CupertinoIcons.chevron_down,
                      color: textColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: TextEmojiInputField(),
          ),
        ],
      ),
    );
  }
}

class _ConversationDate extends StatelessWidget {
  const _ConversationDate();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xDFFFFFFF),
          borderRadius: BorderRadius.circular(11),
        ),
        child: const Text(
          '2024年1月14日',
          style: TextStyle(
            color: CupertinoColors.systemGrey,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _EncryptionNotice extends StatelessWidget {
  const _EncryptionNotice();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xE8FFF7DF),
          borderRadius: BorderRadius.circular(9),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.lock_fill,
              color: Color(0xFFB4872C),
              size: 11,
            ),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                '消息和通话已进行端到端加密，只有此聊天中的成员可以查看、收听或分享。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF695A37),
                  fontSize: 8.5,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
