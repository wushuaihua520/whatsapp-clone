import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../../../utils/constants.dart';
import '../controller/message_controller.dart';

class TextEmojiInputField extends StatefulWidget {
  const TextEmojiInputField({super.key});

  @override
  State<TextEmojiInputField> createState() => _TextEmojiInputFieldState();
}

class _TextEmojiInputFieldState extends State<TextEmojiInputField> {
  final TextEditingController controller = TextEditingController();
  bool isTyping = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x66F2F2F7), Color(0xE6F2F2F7)],
            ),
          ),
          child: SafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(6, 6, 6, 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.all(4),
                  minSize: 0,
                  onPressed: () {},
                  child: const Icon(
                    CupertinoIcons.plus,
                    size: 28,
                    color: textColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 36),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFD8D8DC)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            controller: controller,
                            placeholder: '消息',
                            padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                            decoration: null,
                            maxLines: 5,
                            minLines: 1,
                            onChanged: (value) {
                              final hasText = value.trim().isNotEmpty;
                              if (hasText != isTyping) {
                                setState(() => isTyping = hasText);
                              }
                            },
                          ),
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(6),
                          minSize: 0,
                          onPressed: () {},
                          child: const Icon(
                            CupertinoIcons.smiley,
                            size: 22,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isTyping)
                  CupertinoButton(
                    key: const Key('send-message-button'),
                    padding: const EdgeInsets.all(4),
                    minSize: 0,
                    onPressed: _handlePrimaryAction,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Color(0xFF25D366),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.arrow_up,
                        color: CupertinoColors.white,
                        size: 18,
                      ),
                    ),
                  )
                else ...[
                  CupertinoButton(
                    padding: const EdgeInsets.all(4),
                    minSize: 0,
                    onPressed: () {},
                    child: const Icon(
                      CupertinoIcons.camera_fill,
                      size: 24,
                      color: textColor,
                    ),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.all(4),
                    minSize: 0,
                    onPressed: () {},
                    child: const Icon(
                      CupertinoIcons.mic_fill,
                      size: 24,
                      color: textColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handlePrimaryAction() {
    if (!isTyping) return;
    MessageController.addMessage(controller.text.trim());
    controller.clear();
    setState(() => isTyping = false);
  }
}
