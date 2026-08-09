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
            tooltip: 'Add attachment',
            size: 46,
            iconColor: textColor,
            onPressed: () {},
          ),
          const SizedBox(width: 7),
          Expanded(
            child: GlassSurface(
              borderRadius: 24,
              blur: 24,
              opacity: 0.7,
              boxShadow: false,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 46),
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
                          contentPadding: EdgeInsets.fromLTRB(15, 13, 6, 12),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: '相机',
                      onPressed: () {},
                      icon: const Icon(
                        Icons.photo_camera_outlined,
                        color: iosBlue,
                        size: 23,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 7),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: isTyping
                ? Material(
                    key: const ValueKey('send'),
                    color: iosBlue,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      key: const Key('send-message-button'),
                      customBorder: const CircleBorder(),
                      onTap: _handlePrimaryAction,
                      child: const SizedBox(
                        width: 46,
                        height: 46,
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  )
                : GlassCircleButton(
                    key: const ValueKey('mic'),
                    icon: Icons.mic_none_rounded,
                    tooltip: '语音消息',
                    size: 46,
                    iconColor: iosBlue,
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
