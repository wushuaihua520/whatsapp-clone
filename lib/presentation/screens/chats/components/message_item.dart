import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/participants_chat_model.dart';
import '../../../../utils/constants.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({
    super.key,
    required this.element,
    required this.messages,
  });
  final Messages element;
  final List<Messages> messages;

  bool get isMe => element.sender == 'user';

  int get _index => messages.indexWhere((m) => m.id == element.id);

  bool get _isFirstInCluster {
    final idx = _index;
    if (idx <= 0) return true;
    return messages[idx - 1].sender != element.sender;
  }

  bool get _isLastInCluster {
    final idx = _index;
    if (idx < 0 || idx >= messages.length - 1) return true;
    return messages[idx + 1].sender != element.sender;
  }

  @override
  Widget build(BuildContext context) {
    if (element.isSticker) {
      return _StickerMessage(element: element, isMe: isMe);
    }
    if (element.image != null && element.image!.isNotEmpty) {
      return _ImageMessage(element: element, isMe: isMe);
    }
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.78.sw),
        margin: EdgeInsets.only(
          top: _isFirstInCluster ? 5.h : 1.5.h,
          bottom: _isLastInCluster ? 2.h : 0.5.h,
          left: isMe ? 48.w : 6.w,
          right: isMe ? 6.w : 48.w,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? userMessageBg : senderMessageBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 16 : (_isFirstInCluster ? 16 : 6)),
              topRight:
                  Radius.circular(isMe ? (_isFirstInCluster ? 16 : 6) : 16),
              bottomLeft:
                  Radius.circular(isMe ? 16 : (_isLastInCluster ? 4 : 6)),
              bottomRight:
                  Radius.circular(isMe ? (_isLastInCluster ? 4 : 6) : 16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 1.5,
                offset: const Offset(0, 0.5),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(9.w, 6.h, 9.w, 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (element.replyTo != null) ...[
                _QuoteBlock(
                  author: element.replyAuthor ?? '',
                  text: element.replyTo!,
                  isMe: isMe,
                ),
                SizedBox(height: 4.h),
              ],
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: isMe ? 54.w : 38.w),
                    child: Text(
                      element.message,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.28,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _TimeAndStatus(element: element, isMe: isMe),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuoteBlock extends StatelessWidget {
  const _QuoteBlock({
    required this.author,
    required this.text,
    required this.isMe,
  });
  final String author;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
      decoration: BoxDecoration(
        color: isMe ? quoteBg : const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: isMe ? const Color(0xFF34B7F1) : primaryColor,
            width: 3.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (author.isNotEmpty)
            Text(
              author,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isMe ? const Color(0xFF34B7F1) : primaryDark,
              ),
            ),
          Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeAndStatus extends StatelessWidget {
  const _TimeAndStatus({required this.element, required this.isMe});
  final Messages element;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat('HH:mm').format(element.date),
          style: TextStyle(
            fontSize: 11.sp,
            color: secondaryLabel,
            height: 1,
          ),
        ),
        if (isMe) ...[
          SizedBox(width: 2.w),
          Icon(
            element.seen || element.delivered ? Icons.done_all : Icons.done,
            size: 15.sp,
            color: element.seen ? checkBlue : secondaryLabel,
          ),
        ],
      ],
    );
  }
}

class _ImageMessage extends StatelessWidget {
  const _ImageMessage({
    required this.element,
    required this.isMe,
  });
  final Messages element;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    element.image!,
                    fit: BoxFit.cover,
                    width: 0.62.sw,
                    height: 0.72.sw,
                    errorBuilder: (_, __, ___) => Container(
                      width: 0.62.sw,
                      height: 0.72.sw,
                      color: searchBarBg,
                      child: const Icon(CupertinoIcons.photo, size: 40),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 6,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      DateFormat('HH:mm').format(element.date),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (!isMe) ...[
              SizedBox(width: 8.w),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  CupertinoIcons.arrowshape_turn_up_right,
                  size: 16.sp,
                  color: secondaryLabel,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StickerMessage extends StatelessWidget {
  const _StickerMessage({required this.element, required this.isMe});
  final Messages element;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              element.message.isNotEmpty ? element.message : '☕',
              style: TextStyle(fontSize: 64.sp, height: 1.1),
            ),
            Text(
              DateFormat('HH:mm').format(element.date),
              style: TextStyle(fontSize: 11.sp, color: secondaryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
