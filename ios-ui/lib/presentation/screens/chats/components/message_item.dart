import 'package:flutter/cupertino.dart';
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

    if (element.image != null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          key: Key('message-${element.id}'),
          width: width * 0.6,
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: senderMessageBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: AspectRatio(
              aspectRatio: 0.8,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(element.image!, fit: BoxFit.cover),
                  Positioned(
                    right: 7,
                    bottom: 6,
                    child: Text(
                      DateFormat.Hm().format(element.date),
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

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
        ),
        child: Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: 6,
          children: [
            Text(
              element.message,
              style: const TextStyle(
                fontSize: 16,
                height: 1.25,
                color: textColor,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat.Hm().format(element.date),
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 10.5,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 3),
                  Icon(
                    CupertinoIcons.checkmark_alt,
                    size: 14,
                    color: element.seen
                        ? readReceiptColor
                        : CupertinoColors.systemGrey,
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
