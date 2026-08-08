import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
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
  bool enableEmoji = false;
  bool isTyping = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SafeArea(
          top: false,
          minimum: const EdgeInsets.fromLTRB(6, 4, 6, 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x16000000),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        tooltip: enableEmoji ? 'Keyboard' : 'Emoji',
                        onPressed: () {
                          if (FocusScope.of(context).hasFocus) {
                            FocusScope.of(context).unfocus();
                          }
                          setState(() => enableEmoji = !enableEmoji);
                        },
                        icon: Icon(
                          enableEmoji
                              ? Icons.keyboard_alt_outlined
                              : Icons.emoji_emotions_outlined,
                          color: subTitleTextColor,
                          size: 25,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          cursorColor: primaryColor,
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
                          onTap: () {
                            if (enableEmoji) {
                              setState(() => enableEmoji = false);
                            }
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            filled: false,
                            hintText: 'Message',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Attach',
                        onPressed: () {},
                        icon: Transform.rotate(
                          angle: -0.8,
                          child: const Icon(
                            Icons.attach_file_rounded,
                            color: subTitleTextColor,
                            size: 24,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Camera',
                        onPressed: () {},
                        icon: const Icon(
                          Icons.photo_camera_outlined,
                          color: subTitleTextColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Material(
                color: actionGreen,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  key: const Key('send-message-button'),
                  customBorder: const CircleBorder(),
                  onTap: _handlePrimaryAction,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      isTyping ? Icons.send_rounded : Icons.mic_rounded,
                      color: blackColor,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (enableEmoji)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
            child: EmojiPicker(
              textEditingController: controller,
              onEmojiSelected: (_, __) {
                if (!isTyping) {
                  setState(() => isTyping = true);
                }
              },
              config: Config(
                columns: 7,
                emojiSizeMax: 24,
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.zero,
                initCategory: Category.RECENT,
                bgColor: const Color(0xFFF7F8FA),
                indicatorColor: primaryColor,
                iconColor: subTitleTextColor,
                iconColorSelected: primaryColor,
                backspaceColor: primaryColor,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: subTitleTextColor,
                enableSkinTones: true,
                recentTabBehavior: RecentTabBehavior.RECENT,
                recentsLimit: 28,
                noRecents: const Text(
                  'No Recents',
                  style: TextStyle(fontSize: 20, color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
                loadingIndicator: const SizedBox.shrink(),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
              ),
            ),
          ),
      ],
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
