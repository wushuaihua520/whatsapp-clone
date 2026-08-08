import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/chats_model.dart';
import '../../../../utils/constants.dart';
import '../../../core/routes/routes_name.dart';

class ParticipateTile extends StatelessWidget {
  const ParticipateTile({
    super.key,
    required this.element,
  });

  final Participant element;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.inbox);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: searchFieldColor,
              backgroundImage: AssetImage(element.avatar),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          element.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: hTextColor,
                            letterSpacing: -0.15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formattedTime,
                        style: TextStyle(
                          fontWeight: element.unread > 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: 12,
                          color: element.unread > 0
                              ? primaryColor
                              : subTitleTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (element.messageFrom == 'user') ...[
                        Icon(
                          element.delivered
                              ? Icons.done_all_rounded
                              : Icons.check_rounded,
                          color: element.seen
                              ? readReceiptColor
                              : subTitleTextColor,
                          size: 18,
                        ),
                        const SizedBox(width: 3),
                      ],
                      Expanded(
                        child: Text(
                          element.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: element.unread > 0
                                ? FontWeight.w500
                                : FontWeight.w400,
                            fontSize: 14,
                            color: subTitleTextColor,
                          ),
                        ),
                      ),
                      if (element.unread > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          constraints:
                              const BoxConstraints(minWidth: 20, minHeight: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: actionGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            element.unread.toString(),
                            style: const TextStyle(
                              color: blackColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _formattedTime {
    final date = DateTime.tryParse(element.date);
    if (date == null) {
      return '';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(date.year, date.month, date.day);
    final difference = today.difference(messageDay).inDays;

    if (difference == 0) {
      return DateFormat.jm().format(date);
    }
    if (difference == 1) {
      return 'Yesterday';
    }
    if (difference < 7) {
      return DateFormat.E().format(date);
    }
    return DateFormat.Md().format(date);
  }
}
