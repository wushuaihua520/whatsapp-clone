import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../widgets/glass_surface.dart';
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
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(8, 5, 8, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GlassCircleButton(
            icon: Icons.add_rounded,
            tooltip: '添加',
            size: 42,
            iconColor: textColor,
            opacity: 0.46,
            blur: 34,
            onPressed: () {},
          ),
          const SizedBox(width: 6),
          Expanded(
            child: GlassSurface(
              borderRadius: 23,
              blur: 36,
              opacity: 0.46,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 44),
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
                        decoration: const InputDecoration(
                          isDense: true,
                          filled: false,
                          hintText: '消息',
                          hintStyle: TextStyle(
                            color: iosSecondaryLabel,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(14, 12, 5, 11),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: '相机',
                      onPressed: () {},
                      icon: const Icon(
                        Icons.photo_camera_outlined,
                        color: textColor,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: isTyping
                ? Material(
                    key: const ValueKey('send'),
                    color: const Color(0xFF20C56D),
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      key: const Key('send-message-button'),
                      customBorder: const CircleBorder(),
                      onTap: _handlePrimaryAction,
                      child: const SizedBox(
                        width: 42,
                        height: 42,
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),
                  )
                : GlassCircleButton(
                    key: const ValueKey('mic'),
                    icon: Icons.mic_none_rounded,
                    tooltip: '语音消息',
                    size: 42,
                    iconColor: textColor,
                    opacity: 0.46,
                    blur: 34,
                    onPressed: () {},
                  ),
          ),
        ],
      ),
    );
  }

  void _handlePrimaryAction() {
    if (!isTyping) {
      return;
    }

    MessageController.addMessage(controller.text.trim());
    controller.clear();
    setState(() => isTyping = false);
  }
}
