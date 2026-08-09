import 'package:flutter/material.dart';

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
    final unread = element.unread > 0;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteNames.inbox),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ReferenceAvatar(element: element),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          element.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: hTextColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      if (element.id == 1) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified_rounded,
                          color: primaryColor,
                          size: 14,
                        ),
                      ],
                      const SizedBox(width: 8),
                      Text(
                        _formattedTime,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: unread ? primaryColor : iosSecondaryLabel,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          element.lastMessage,
                          maxLines: element.id == 1 ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: unread ? FontWeight.w500 : FontWeight.w400,
                            fontSize: 14.5,
                            height: 1.25,
                            color: unread
                                ? const Color(0xFF3C3C43)
                                : iosSecondaryLabel,
                          ),
                        ),
                      ),
                      if (unread) ...[
                        const SizedBox(width: 8),
                        Container(
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xFF25D366),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            element.unread > 99 ? '99+' : '${element.unread}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1,
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
    if (date == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(date.year, date.month, date.day);
    final diff = today.difference(messageDay).inDays;

    if (diff == 0) {
      final hour = date.hour;
      final minute = date.minute.toString().padLeft(2, '0');
      if (hour < 12) {
        return '上午 ${hour == 0 ? 12 : hour}:$minute';
      }
      final h = hour == 12 ? 12 : hour - 12;
      return '下午 $h:$minute';
    }
    if (diff == 1) return '昨天';
    if (diff < 7) {
      const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
      return weekdays[date.weekday - 1];
    }
    return '${date.year}/${date.month}/${date.day}';
  }
}

class _ReferenceAvatar extends StatelessWidget {
  const _ReferenceAvatar({required this.element});

  final Participant element;

  @override
  Widget build(BuildContext context) {
    if (element.id == 1) {
      return SizedBox(
        width: 52,
        height: 52,
        child: Image.asset(element.avatar, fit: BoxFit.contain),
      );
    }

    return const CircleAvatar(
      radius: 26,
      backgroundColor: Color(0xFFF4E7C9),
      child: Icon(
        Icons.person_rounded,
        color: Color(0xFFB78032),
        size: 28,
      ),
    );
  }
}
