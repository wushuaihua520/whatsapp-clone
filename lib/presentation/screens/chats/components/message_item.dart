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

  bool get _isFirstInCluster {
    final idx = messages.indexOf(element);
    if (idx <= 0) return true;
    final prev = messages[idx - 1];
    return prev.sender != element.sender;
  }

  bool get _isLastInCluster {
    final idx = messages.indexOf(element);
    if (idx < 0 || idx >= messages.length - 1) return true;
    final next = messages[idx + 1];
    return next.sender != element.sender;
  }

  @override
  Widget build(BuildContext context) {
    if (element.isSticker) {
      return _StickerMessage(element: element, isMe: isMe);
    }
    if (element.image != null && element.image!.isNotEmpty) {
      return _ImageMessage(
        element: element,
        isMe: isMe,
        showTail: _isLastInCluster,
      );
    }
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.78.sw),
        margin: EdgeInsets.only(
          top: _isFirstInCluster ? 6.h : 2.h,
          bottom: _isLastInCluster ? 2.h : 1.h,
          left: isMe ? 40.w : 4.w,
          right: isMe ? 4.w : 40.w,
        ),
        child: CustomPaint(
          painter: _BubblePainter(
            color: isMe ? userMessageBg : senderMessageBg,
            isMe: isMe,
            showTail: _isLastInCluster,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isMe ? 10.w : (_isLastInCluster ? 14.w : 10.w),
              7.h,
              isMe ? (_isLastInCluster ? 14.w : 10.w) : 10.w,
              7.h,
            ),
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
                      padding: EdgeInsets.only(right: isMe ? 52.w : 40.w),
                      child: Text(
                        element.message,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.25,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: -1,
                      child: _TimeAndStatus(element: element, isMe: isMe),
                    ),
                  ],
                ),
              ],
            ),
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
            width: 3,
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
            element.seen || element.delivered
                ? Icons.done_all
                : Icons.done,
            size: 14.sp,
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
    required this.showTail,
  });
  final Messages element;
  final bool isMe;
  final bool showTail;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.72.sw),
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.asset(
                element.image!,
                fit: BoxFit.cover,
                width: 0.68.sw,
                errorBuilder: (_, __, ___) => Container(
                  width: 0.68.sw,
                  height: 280.h,
                  color: searchBarBg,
                  child: const Icon(CupertinoIcons.photo, size: 40),
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
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (element.image != null)
              Image.asset(
                element.image!,
                width: 140.w,
                height: 140.w,
                errorBuilder: (_, __, ___) => Text(
                  element.message.isNotEmpty ? element.message : '😊',
                  style: TextStyle(fontSize: 72.sp),
                ),
              )
            else
              Text(
                element.message.isNotEmpty ? element.message : '☕',
                style: TextStyle(fontSize: 72.sp),
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

class _BubblePainter extends CustomPainter {
  _BubblePainter({
    required this.color,
    required this.isMe,
    required this.showTail,
  });

  final Color color;
  final bool isMe;
  final bool showTail;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final r = RRect.fromRectAndCorners(
      Rect.fromLTWH(isMe ? 0 : (showTail ? 4 : 0), 0,
          size.width - (showTail ? 4 : 0), size.height),
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isMe ? 16 : (showTail ? 4 : 16)),
      bottomRight: Radius.circular(isMe ? (showTail ? 4 : 16) : 16),
    );
    canvas.drawRRect(r, paint);

    // subtle shadow edge
    final border = Paint()
      ..color = Colors.black.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawRRect(r, border);
  }

  @override
  bool shouldRepaint(covariant _BubblePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.isMe != isMe ||
        oldDelegate.showTail != showTail;
  }
}
