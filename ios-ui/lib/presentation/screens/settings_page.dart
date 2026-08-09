import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

import '../../utils/constants.dart';

/// Profile / 「自己」 — 1:1 WhatsApp iOS settings chrome.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: iosGroupedBackground,
      child: CustomScrollView(
        key: const PageStorageKey('ios-settings-list'),
        slivers: [
          const SliverToBoxAdapter(child: _SettingsChrome()),
          const SliverToBoxAdapter(child: _ProfileHero()),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              backgroundColor: iosGroupedBackground,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              children: const [
                _SettingsTile(
                  icon: CupertinoIcons.list_bullet,
                  title: '列表',
                ),
                _SettingsTile(
                  icon: CupertinoIcons.star,
                  title: '已加星标',
                ),
                _SettingsTile(
                  icon: CupertinoIcons.speaker_2_fill,
                  title: '群发消息',
                ),
                _SettingsTile(
                  icon: CupertinoIcons.desktopcomputer,
                  title: '已关联的设备',
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              backgroundColor: iosGroupedBackground,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              children: const [
                _SettingsTile(
                  icon: Icons.vpn_key_outlined,
                  title: '账户',
                ),
                _SettingsTile(
                  icon: CupertinoIcons.lock,
                  title: '隐私',
                ),
                _SettingsTile(
                  icon: CupertinoIcons.chat_bubble,
                  title: '聊天',
                ),
                _SettingsTile(
                  icon: CupertinoIcons.bell,
                  title: '通知',
                ),
                _SettingsTile(
                  icon: CupertinoIcons.arrow_up_arrow_down,
                  title: '存储空间和数据',
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
    );
  }
}

class _SettingsChrome extends StatelessWidget {
  const _SettingsChrome();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 16, 4),
        child: Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.search,
                size: 24,
                color: textColor,
              ),
            ),
            const Spacer(),
            Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 8,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    minSize: 0,
                    onPressed: () {},
                    child: const Icon(
                      CupertinoIcons.qrcode,
                      size: 18,
                      color: textColor,
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 16,
                    color: const Color(0x4D3C3C43),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    minSize: 0,
                    onPressed: () {},
                    child: const Icon(
                      CupertinoIcons.pencil,
                      size: 18,
                      color: textColor,
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
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 96,
                height: 96,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFF91DCD6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.person_fill,
                    color: Color(0xFF3A3A3C),
                    size: 52,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
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
              CupertinoIcons.info_circle_fill,
              color: iosBlue,
              size: 18,
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leading: Icon(icon, color: textColor, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          color: textColor,
          fontSize: 17,
          letterSpacing: -0.41,
        ),
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: () {},
    );
  }
}
