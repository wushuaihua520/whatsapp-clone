import 'dart:ui';

import 'package:flutter/material.dart';

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
              colors: [
                Color(0x66F2F2F7),
                Color(0xE6F2F2F7),
              ],
            ),
          ),
          child: SafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(8, 6, 8, 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ComposerIconButton(
                  icon: Icons.add_rounded,
                  tooltip: '添加',
                  onPressed: () {},
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 36),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFD8D8DC)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            cursorColor: iosBlue,
                            cursorWidth: 2,
                            minLines: 1,
                            maxLines: 5,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (value) {
                              final hasText = value.trim().isNotEmpty;
                              if (hasText != isTyping) {
                                setState(() => isTyping = hasText);
                              }
                            },
                            style: const TextStyle(
                              color: textColor,
                              fontSize: 16,
                              height: 1.2,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              filled: false,
                              hintText: '消息',
                              hintStyle: TextStyle(
                                color: Color(0xFF8E8E93),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 8, 4, 8),
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: '贴纸',
                          onPressed: () {},
                          constraints: const BoxConstraints.tightFor(
                            width: 34,
                            height: 34,
                          ),
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.sticky_note_2_outlined,
                            color: Color(0xFF8E8E93),
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                if (isTyping)
                  _SendButton(onPressed: _handlePrimaryAction)
                else ...[
                  _ComposerIconButton(
                    icon: Icons.photo_camera_outlined,
                    tooltip: '相机',
                    onPressed: () {},
                  ),
                  _ComposerIconButton(
                    icon: Icons.mic_none_rounded,
                    tooltip: '语音消息',
                    onPressed: () {},
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

class _ComposerIconButton extends StatelessWidget {
  const _ComposerIconButton({
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      constraints: const BoxConstraints.tightFor(width: 36, height: 36),
      padding: EdgeInsets.zero,
      icon: Icon(icon, color: textColor, size: 26),
    );
    return button;
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF25D366),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: const Key('send-message-button'),
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: const SizedBox(
          width: 36,
          height: 36,
          child: Icon(Icons.send_rounded, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
