import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/participants_chat_model.dart';
import '../../../../utils/constants.dart';

class MessageComponent extends StatelessWidget {
  const MessageComponent({
    super.key,
    required this.element,
  });

  final Messages element;

  @override
  Widget build(BuildContext context) {
    final isMe = element.sender == 'user';
    final width = MediaQuery.of(context).size.width;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        key: Key('message-${element.id}'),
        constraints: BoxConstraints(maxWidth: width * 0.76),
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.fromLTRB(12, 8, 9, 6),
        decoration: BoxDecoration(
          color: isMe ? userMessageBg : senderMessageBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMe ? 17 : 5),
            topRight: Radius.circular(isMe ? 5 : 17),
            bottomLeft: const Radius.circular(17),
            bottomRight: const Radius.circular(17),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x18000000),
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                element.message,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat.jm().format(element.date),
                  style: const TextStyle(
                    color: iosSecondaryLabel,
                    fontSize: 10.5,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 3),
                  Icon(
                    element.delivered
                        ? Icons.done_all_rounded
                        : Icons.check_rounded,
                    size: 15,
                    color: element.seen ? readReceiptColor : iosSecondaryLabel,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageSeparator extends StatelessWidget {
  const MessageSeparator({
    super.key,
    required this.groupByValue,
  });

  final DateTime groupByValue;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(
      groupByValue.year,
      groupByValue.month,
      groupByValue.day,
    );
    final difference = today.difference(date).inDays;
    final label = difference == 0
        ? 'Today'
        : difference == 1
            ? 'Yesterday'
            : DateFormat.yMMMd().format(groupByValue);

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xDFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x16000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: iosSecondaryLabel,
          ),
        ),
      ),
    );
  }
}
