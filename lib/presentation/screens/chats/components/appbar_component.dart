import 'package:flutter/material.dart';

import '../../../../data/model/participants_chat_model.dart';
import '../../../../utils/constants.dart';

class AvatarAndBackNavigate extends StatelessWidget {
  const AvatarAndBackNavigate({
    super.key,
    required this.user,
  });

  final ParticipantsChat user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        CircleAvatar(
          radius: 18,
          backgroundColor: searchFieldColor,
          backgroundImage: AssetImage(user.avatar),
        ),
      ],
    );
  }
}

class UserAndStatus extends StatelessWidget {
  const UserAndStatus({
    super.key,
    required this.user,
  });

  final ParticipantsChat user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.participant,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          user.status,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: subTitleTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
