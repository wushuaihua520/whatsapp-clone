import 'package:flutter/cupertino.dart';
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
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 116),
        children: const [
          _ProfileHero(),
          SizedBox(height: 18),
          _SettingsSection(
            rows: [
              _SettingsRowData(icon: CupertinoIcons.list_bullet, title: '列表'),
              _SettingsRowData(icon: CupertinoIcons.star, title: '已加星标'),
              _SettingsRowData(
                icon: CupertinoIcons.speaker_2,
                title: '群发消息',
              ),
              _SettingsRowData(
                icon: CupertinoIcons.desktopcomputer,
                title: '已关联的设备',
              ),
            ],
          ),
          SizedBox(height: 18),
          _SettingsSection(
            rows: [
              _SettingsRowData(icon: CupertinoIcons.person_crop_circle, title: '账户'),
              _SettingsRowData(icon: CupertinoIcons.lock, title: '隐私'),
              _SettingsRowData(
                icon: CupertinoIcons.chat_bubble,
                title: '聊天',
              ),
              _SettingsRowData(
                icon: CupertinoIcons.bell,
                title: '通知',
              ),
              _SettingsRowData(
                icon: CupertinoIcons.arrow_up_arrow_down,
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
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 18),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF91DCD6),
                child: Icon(
                  CupertinoIcons.person_fill,
                  color: Color(0xFF3A3A3C),
                  size: 52,
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  '最新动态',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '心如止水',
              style: TextStyle(
                color: textColor,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              CupertinoIcons.info_circle,
              color: primaryColor,
              size: 18,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            _SettingsRow(data: rows[index]),
            if (index < rows.length - 1)
              const Divider(height: 1, indent: 52, color: Color(0xFFE5E5EA)),
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
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Icon(data.icon, color: textColor, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                data.title,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_forward,
              color: Color(0xFFC7C7CC),
              size: 18,
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
