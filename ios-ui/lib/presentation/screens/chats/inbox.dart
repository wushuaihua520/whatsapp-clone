import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../data/dummy_data.dart';
import '../../../data/model/participants_chat_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/glass_surface.dart';
import '../../core/routes/routes_name.dart';
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
              child: StreamBuilder<List<Messages>>(
                stream: MessageController.streamData,
                initialData: MessageController.list,
                builder: (context, snapshot) {
                  final messages = snapshot.data ?? user.messages;
                  if (messages.isEmpty) {
                    return const SizedBox();
                  }
                  final sortedMessages = messages.toList()
                    ..sort((a, b) => a.date.compareTo(b.date));
                  return ListView(
                    padding: EdgeInsets.fromLTRB(
                      10,
                      MediaQuery.of(context).padding.top + 70,
                      10,
                      MediaQuery.of(context).padding.bottom + 96,
                    ),
                    children: [
                      const _ConversationDate(),
                      const _EncryptionNotice(),
                      const SizedBox(height: 8),
                      ...sortedMessages.map(
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
              child: _GlassChatHeader(user: user),
            ),
            Positioned(
              right: 12,
              bottom: MediaQuery.of(context).padding.bottom + 66,
              child: GlassCircleButton(
                key: const Key('ios-jump-to-latest'),
                icon: Icons.keyboard_arrow_down_rounded,
                tooltip: '最新消息',
                size: 36,
                iconColor: textColor,
                opacity: 0.46,
                blur: 34,
                onPressed: () {},
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
          Color(0x2BFFFFFF),
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xB8FFFFFF),
                Color(0x73FFFFFF),
                Color(0x14FFFFFF),
              ],
              stops: [0, 0.72, 1],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 62,
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  GestureDetector(
                    key: const Key('ios-chat-back'),
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        color: Color(0xFF3C3C43),
                        size: 32,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        key: const Key('ios-chat-avatar'),
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Navigator.pushNamed(
                          context,
                          RouteNames.contactInfo,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xFFF4E7C9),
                              child: Icon(
                                Icons.person_rounded,
                                color: Color(0xFFB78032),
                                size: 17,
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
                                  letterSpacing: -0.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 34,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xE6FFFFFF),
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: const Color(0x33FFFFFF)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: '视频通话',
                          onPressed: () {},
                          constraints: const BoxConstraints.tightFor(
                            width: 36,
                            height: 34,
                          ),
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.videocam_outlined,
                            color: textColor,
                            size: 22,
                          ),
                        ),
                        IconButton(
                          tooltip: '语音通话',
                          onPressed: () {},
                          constraints: const BoxConstraints.tightFor(
                            width: 36,
                            height: 34,
                          ),
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.call_outlined,
                            color: textColor,
                            size: 19,
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
          color: const Color(0xDFFFFFFF),
          borderRadius: BorderRadius.circular(11),
          boxShadow: const [
            BoxShadow(
              color: Color(0x15000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: const Text(
          '2024年1月14日',
          style: TextStyle(
            color: iosSecondaryLabel,
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
            Icon(Icons.lock_rounded, color: Color(0xFFB4872C), size: 11),
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
