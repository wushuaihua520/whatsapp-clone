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
        automaticallyImplyLeading: false,
        leadingWidth: 78,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: iosBlue,
            padding: const EdgeInsets.only(left: 10),
          ),
          child: const Text(
            '取消',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ),
        title: const Text('新聊天'),
        actions: [
          IconButton(
            tooltip: '扫描二维码',
            onPressed: () {},
            icon: const Icon(Icons.qr_code_rounded, color: iosBlue),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 4, bottom: 24),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 5, 16, 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索姓名或号码',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: iosSecondaryLabel,
                  size: 21,
                ),
              ),
            ),
          ),
          const NewOption(
            icon: Icons.group_add_rounded,
            title: '新建群组',
          ),
          const NewOption(
            icon: Icons.person_add_alt_1_rounded,
            title: '新建联系人',
            trail: Icon(
              Icons.chevron_right_rounded,
              color: iosSeparator,
              size: 22,
            ),
          ),
          const NewOption(
            icon: Icons.groups_rounded,
            title: '新建社区',
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 7),
            child: Text(
              '联系人',
              style: TextStyle(
                color: iosSecondaryLabel,
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
        radius: 22,
        backgroundColor: const Color(0xFFE5F1FF),
        child: Icon(
          icon,
          color: iosBlue,
          size: 22,
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
        radius: 23,
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
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: iosSeparator,
        size: 21,
      ),
    );
  }
}
