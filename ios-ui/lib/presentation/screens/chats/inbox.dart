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
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              KImages.defaultWallpaper,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const ColoredBox(
                color: Color(0xFFEFE6D8),
                child: CustomPaint(painter: _DoodlePainter()),
              ),
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
                    MediaQuery.of(context).padding.top + 58,
                    10,
                    MediaQuery.of(context).padding.bottom + 78,
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
            top: 0,
            left: 0,
            right: 0,
            child: _FrostedChatHeader(user: user),
          ),
          Positioned(
            right: 12,
            bottom: MediaQuery.of(context).padding.bottom + 70,
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: CupertinoButton(
                  key: const Key('ios-jump-to-latest'),
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: () {},
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xCCFFFFFF),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0x33FFFFFF)),
                    ),
                    child: const Icon(
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

class _FrostedChatHeader extends StatelessWidget {
  const _FrostedChatHeader({required this.user});

  final ParticipantsChat user;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xD9F7F7F7),
                Color(0x99F7F7F7),
                Color(0x33F7F7F7),
              ],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 48,
              child: Row(
                children: [
                  CupertinoButton(
                    key: const Key('ios-chat-back'),
                    padding: const EdgeInsets.only(left: 4),
                    minSize: 0,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(
                      CupertinoIcons.back,
                      size: 28,
                      color: textColor,
                    ),
                  ),
                  Expanded(
                    child: CupertinoButton(
                      key: const Key('ios-chat-avatar'),
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      onPressed: () => Navigator.of(context)
                          .pushNamed(RouteNames.contactInfo),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF4E7C9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.person_fill,
                              color: Color(0xFFB78032),
                              size: 16,
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
                  ),
                  Container(
                    height: 32,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xF2FFFFFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0x33FFFFFF)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          minSize: 0,
                          onPressed: () {},
                          child: const Icon(
                            CupertinoIcons.videocam_fill,
                            size: 20,
                            color: textColor,
                          ),
                        ),
                        Container(
                          width: 0.5,
                          height: 16,
                          color: const Color(0x4D3C3C43),
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          minSize: 0,
                          onPressed: () {},
                          child: const Icon(
                            CupertinoIcons.phone_fill,
                            size: 18,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
          color: const Color(0xD9FFFFFF),
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

class _DoodlePainter extends CustomPainter {
  const _DoodlePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x22000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var y = 20.0; y < size.height; y += 48) {
      for (var x = 16.0; x < size.width; x += 52) {
        canvas.drawCircle(Offset(x, y), 3, paint);
        canvas.drawLine(Offset(x + 10, y - 4), Offset(x + 22, y + 4), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
