import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/k_images.dart';

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
          _ProfileCard(),
          SizedBox(height: 22),
          _SettingsSection(
            rows: [
              _SettingsRowData(
                icon: Icons.star_rounded,
                iconColor: Color(0xFFFFC107),
                title: 'Starred Messages',
              ),
              _SettingsRowData(
                icon: Icons.devices_rounded,
                iconColor: Color(0xFF34C759),
                title: 'Linked Devices',
              ),
            ],
          ),
          SizedBox(height: 22),
          _SettingsSection(
            rows: [
              _SettingsRowData(
                icon: Icons.key_rounded,
                iconColor: Color(0xFF007AFF),
                title: 'Account',
              ),
              _SettingsRowData(
                icon: Icons.lock_rounded,
                iconColor: Color(0xFF34C759),
                title: 'Privacy',
              ),
              _SettingsRowData(
                icon: Icons.chat_bubble_rounded,
                iconColor: Color(0xFF25D366),
                title: 'Chats',
              ),
              _SettingsRowData(
                icon: Icons.notifications_rounded,
                iconColor: Color(0xFFFF3B30),
                title: 'Notifications',
              ),
              _SettingsRowData(
                icon: Icons.data_usage_rounded,
                iconColor: Color(0xFF34C759),
                title: 'Storage and Data',
              ),
            ],
          ),
          SizedBox(height: 22),
          _SettingsSection(
            rows: [
              _SettingsRowData(
                icon: Icons.help_rounded,
                iconColor: Color(0xFF007AFF),
                title: 'Help',
              ),
              _SettingsRowData(
                icon: Icons.person_add_alt_1_rounded,
                iconColor: Color(0xFFFF2D55),
                title: 'Invite a Friend',
              ),
            ],
          ),
          SizedBox(height: 28),
          Center(
            child: Text(
              'WhatsApp from Meta',
              style: TextStyle(color: iosSecondaryLabel, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 31,
                backgroundImage: AssetImage(KImages.chatAvatar1),
              ),
              SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Martin Troff',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Available',
                      style: TextStyle(
                        color: iosSecondaryLabel,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.qr_code_rounded, color: iosBlue, size: 25),
              SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded, color: iosSeparator),
            ],
          ),
        ),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        child: Row(
          children: [
            Container(
              width: 31,
              height: 31,
              decoration: BoxDecoration(
                color: data.iconColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(data.icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                data.title,
                style: const TextStyle(color: textColor, fontSize: 16),
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
    required this.iconColor,
    required this.title,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
}
