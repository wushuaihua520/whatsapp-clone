import 'dart:io' show Platform;

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/utils.dart';
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

  bool get _isApple {
    if (kIsWeb) return false;
    try {
      return Platform.isIOS || Platform.isMacOS;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.fromLTRB(8.w, 6.h, 8.w, bottom > 0 ? bottom : 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            border: const Border(
              top: BorderSide(color: Color(0xFFE5E5EA), width: 0.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Icon(
                  CupertinoIcons.plus,
                  size: 28.sp,
                  color: const Color(0xFF007AFF),
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(minHeight: 36.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFD1D1D6),
                      width: 0.8,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: TextField(
                    controller: controller,
                    cursorColor: primaryColor,
                    cursorWidth: 2,
                    minLines: 1,
                    maxLines: 5,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    onChanged: (v) {
                      final typing = v.isNotEmpty;
                      if (typing != isTyping) {
                        setState(() => isTyping = typing);
                      }
                    },
                    onTap: () {
                      if (enableEmoji) {
                        setState(() => enableEmoji = false);
                      }
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                      hintText: '',
                      filled: false,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (FocusScope.of(context).hasFocus) {
                          FocusScope.of(context).unfocus();
                        }
                        setState(() => enableEmoji = !enableEmoji);
                      },
                      child: Icon(
                        enableEmoji
                            ? CupertinoIcons.keyboard
                            : CupertinoIcons.smiley,
                        size: 26.sp,
                        color: const Color(0xFF8E8E93),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () => Utils.openCamera(),
                      child: Icon(
                        CupertinoIcons.camera,
                        size: 24.sp,
                        color: const Color(0xFF8E8E93),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        if (isTyping) {
                          MessageController.addMessage(controller.text);
                          controller.clear();
                          setState(() => isTyping = false);
                        }
                      },
                      child: Icon(
                        isTyping
                            ? CupertinoIcons.paperplane_fill
                            : CupertinoIcons.mic,
                        size: 24.sp,
                        color: isTyping
                            ? primaryColor
                            : const Color(0xFF8E8E93),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (enableEmoji)
          SizedBox(
            height: 280.h,
            child: EmojiPicker(
              textEditingController: controller,
              onEmojiSelected: (category, emoji) {
                if (!isTyping) setState(() => isTyping = true);
              },
              config: Config(
                columns: 8,
                emojiSizeMax: 28 * (_isApple ? 1.2 : 1.0),
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: primaryColor,
                iconColorSelected: primaryColor,
                backspaceColor: primaryColor,
                noRecents: const Text(
                  'No Recents',
                  style: TextStyle(fontSize: 20, color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
