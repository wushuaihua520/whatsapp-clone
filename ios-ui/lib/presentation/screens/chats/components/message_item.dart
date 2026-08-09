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
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              key: Key('message-${element.id}'),
              width: width * 0.58,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: senderMessageBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 0.72,
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
                            shadows: [
                              Shadow(
                                color: Color(0x88000000),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFE5E5EA),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.arrowshape_turn_up_right_fill,
                size: 14,
                color: Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        key: Key('message-${element.id}'),
        constraints: BoxConstraints(maxWidth: width * 0.76),
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.fromLTRB(11, 7, 8, 5),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFE1FEC6) : senderMessageBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMe ? 12 : 4),
            topRight: Radius.circular(isMe ? 4 : 12),
            bottomLeft: const Radius.circular(12),
            bottomRight: const Radius.circular(12),
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
                  const SizedBox(width: 2),
                  SizedBox(
                    width: 16,
                    height: 12,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: Icon(
                            CupertinoIcons.checkmark_alt,
                            size: 13,
                            color: element.seen
                                ? readReceiptColor
                                : const Color(0xFF8E8E93),
                          ),
                        ),
                        Positioned(
                          left: 4,
                          child: Icon(
                            CupertinoIcons.checkmark_alt,
                            size: 13,
                            color: element.seen
                                ? readReceiptColor
                                : const Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
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
