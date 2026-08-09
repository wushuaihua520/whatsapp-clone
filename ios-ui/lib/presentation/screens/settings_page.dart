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
          SizedBox(height: 14),
          _SettingsSection(
            rows: [
              _SettingsRowData(
                icon: Icons.list_alt_rounded,
                title: '列表',
                tint: Color(0xFF34C759),
              ),
              _SettingsRowData(
                icon: Icons.star_border_rounded,
                title: '已加星标',
                tint: Color(0xFFFFCC00),
              ),
              _SettingsRowData(
                icon: Icons.campaign_outlined,
                title: '群发消息',
                tint: Color(0xFF007AFF),
              ),
              _SettingsRowData(
                icon: Icons.devices_outlined,
                title: '已关联的设备',
                tint: Color(0xFF8E8E93),
              ),
            ],
          ),
          SizedBox(height: 18),
          _SettingsSection(
            rows: [
              _SettingsRowData(
                icon: Icons.key_rounded,
                title: '账户',
                tint: Color(0xFF007AFF),
              ),
              _SettingsRowData(
                icon: Icons.lock_outline_rounded,
                title: '隐私',
                tint: Color(0xFF34C759),
              ),
              _SettingsRowData(
                icon: Icons.face_retouching_natural,
                title: '头像',
                tint: Color(0xFFAF52DE),
              ),
              _SettingsRowData(
                icon: Icons.chat_bubble_outline_rounded,
                title: '聊天',
                tint: Color(0xFF34C759),
              ),
              _SettingsRowData(
                icon: Icons.notifications_none_rounded,
                title: '通知',
                tint: Color(0xFFFF3B30),
              ),
              _SettingsRowData(
                icon: Icons.swap_vert_rounded,
                title: '存储空间和数据',
                tint: Color(0xFF007AFF),
              ),
            ],
          ),
          SizedBox(height: 18),
          _SettingsSection(
            rows: [
              _SettingsRowData(
                icon: Icons.help_outline_rounded,
                title: '帮助',
                tint: Color(0xFF007AFF),
              ),
              _SettingsRowData(
                icon: Icons.favorite_border_rounded,
                title: '邀请好友',
                tint: Color(0xFFFF2D55),
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
            color: Color(0xFFE9E9EB),
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
        SizedBox(height: 8),
        CircleAvatar(
          radius: 42,
          backgroundColor: Color(0xFF91DCD6),
          child: Icon(
            Icons.person_rounded,
            color: Color(0xFF137D78),
            size: 42,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '心如止水',
              style: TextStyle(
                color: textColor,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          '嘿！我正在使用 WhatsApp.',
          style: TextStyle(
            color: iosSecondaryLabel,
            fontSize: 14,
          ),
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
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            _SettingsRow(data: rows[index]),
            if (index < rows.length - 1)
              const Divider(height: 1, indent: 58, color: Color(0xFFE5E5EA)),
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            Container(
              width: 29,
              height: 29,
              decoration: BoxDecoration(
                color: data.tint,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(data.icon, color: Colors.white, size: 17),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                data.title,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFC7C7CC),
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
    required this.tint,
  });

  final IconData icon;
  final String title;
  final Color tint;
}
