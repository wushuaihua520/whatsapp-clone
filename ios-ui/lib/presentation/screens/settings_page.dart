import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: iosGroupedBackground,
      child: ListView(
        key: const PageStorageKey('ios-settings-list'),
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 116),
        children: const [
          _ProfileHero(),
          SizedBox(height: 15),
          _SettingsSection(
            rows: [
              _SettingsRowData(
                icon: Icons.list_alt_rounded,
                title: '列表',
              ),
              _SettingsRowData(
                icon: Icons.star_border_rounded,
                title: '已加星标',
              ),
              _SettingsRowData(
                icon: Icons.campaign_outlined,
                title: '群发消息',
              ),
              _SettingsRowData(
                icon: Icons.devices_outlined,
                title: '已关联的设备',
              ),
            ],
          ),
          SizedBox(height: 18),
          _SettingsSection(
            rows: [
              _SettingsRowData(
                icon: Icons.key_rounded,
                title: '账户',
              ),
              _SettingsRowData(
                icon: Icons.lock_outline_rounded,
                title: '隐私',
              ),
              _SettingsRowData(
                icon: Icons.chat_bubble_outline_rounded,
                title: '聊天',
              ),
              _SettingsRowData(
                icon: Icons.notifications_none_rounded,
                title: '通知',
              ),
              _SettingsRowData(
                icon: Icons.swap_vert_rounded,
                title: '存储空间和数据',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F2),
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              '最近动态',
              style: TextStyle(
                color: iosSecondaryLabel,
                fontSize: 11,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        CircleAvatar(
          radius: 45,
          backgroundColor: Color(0xFF91DCD6),
          child: Icon(
            Icons.person_rounded,
            color: Color(0xFF137D78),
            size: 44,
          ),
        ),
        SizedBox(height: 9),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '心如止水',
              style: TextStyle(
                color: textColor,
                fontSize: 21,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.verified_outlined,
              color: primaryColor,
              size: 15,
            ),
          ],
        ),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.rows});

  final List<_SettingsRowData> rows;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            _SettingsRow(data: rows[index]),
            if (index < rows.length - 1)
              const Divider(indent: 58, color: dividerColor),
          ],
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.data});

  final _SettingsRowData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Icon(data.icon, color: textColor, size: 18),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                data.title,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: iosSeparator,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRowData {
  const _SettingsRowData({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
}
