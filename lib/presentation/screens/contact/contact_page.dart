import 'package:flutter/material.dart';

import '../../../data/dummy_data.dart';
import '../../../utils/constants.dart';
import '../../core/routes/routes_name.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select contact',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '299 contacts',
              style: TextStyle(
                color: subTitleTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
          PopupMenuButton<String>(
              tooltip: 'More options',
              icon: const Icon(Icons.more_vert_rounded),
              offset: const Offset(0, 60),
              itemBuilder: (context) {
                return const <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'invite',
                    child: Text('Invite a friend'),
                  ),
                  PopupMenuItem<String>(
                    value: 'contacts',
                    child: Text('Contacts'),
                  ),
                  PopupMenuItem<String>(
                    value: 'refresh',
                    child: Text('Refresh'),
                  ),
                  PopupMenuItem<String>(value: 'help', child: Text('Help')),
                ];
              }),
          const SizedBox(width: 4),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 6, bottom: 24),
        children: [
          const NewOption(
            icon: Icons.group_add_rounded,
            title: 'New group',
          ),
          const NewOption(
            icon: Icons.person_add_alt_1_rounded,
            title: 'New contact',
            trail: Icon(
              Icons.qr_code_rounded,
              color: textColor,
              size: 24,
            ),
          ),
          const NewOption(
            icon: Icons.groups_rounded,
            title: 'New community',
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: Text(
              'Contacts on WhatsApp',
              style: TextStyle(
                color: subTitleTextColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...KDummyData.contacts.map(
            (contact) => ContactTile(
              title: contact['user']!,
              subtitle: contact['status']!,
              avatar: contact['avatar']!,
            ),
          ),
        ],
      ),
    );
  }
}

class NewOption extends StatelessWidget {
  const NewOption({
    super.key,
    required this.title,
    required this.icon,
    this.trail,
  });
  final String title;
  final IconData icon;
  final Widget? trail;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: actionGreen,
        child: Icon(
          icon,
          color: blackColor,
          size: 23,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      trailing: trail,
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.avatar,
  });
  final String title;
  final String subtitle;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, RouteNames.inbox),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: searchFieldColor,
        backgroundImage: AssetImage(avatar),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: subTitleTextColor,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
      trailing: IconButton(
        tooltip: 'Voice call',
        onPressed: () {},
        icon: const Icon(Icons.call_outlined, color: primaryColor),
      ),
    );
  }
}
