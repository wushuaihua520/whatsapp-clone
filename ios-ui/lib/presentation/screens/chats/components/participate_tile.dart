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
      onTap: () => Navigator.pushNamed(context, RouteNames.inbox),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ReferenceAvatar(element: element),
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
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formattedTime,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: iosSecondaryLabel,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    element.lastMessage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.5,
                      height: 1.25,
                      color: iosSecondaryLabel,
                    ),
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
    return DateFormat('yyyy/M/d').format(date);
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
