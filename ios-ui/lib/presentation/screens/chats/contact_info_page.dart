import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../widgets/glass_surface.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iosGroupedBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 58,
        leading: Padding(
          padding: const EdgeInsets.only(left: 9),
          child: GlassCircleButton(
            icon: Icons.chevron_left_rounded,
            tooltip: '返回',
            size: 38,
            iconColor: textColor,
            opacity: 0.42,
            blur: 32,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text('联系人信息'),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: iosBlue),
            child: const Text(
              '编辑',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(width: 7),
        ],
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xD9F7F7FA),
                    Color(0xA6F7F7FA),
                    Color(0x4DF7F7FA),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          key: const Key('ios-contact-info-list'),
          padding: const EdgeInsets.fromLTRB(16, 9, 16, 36),
          children: const [
            _ProfileHero(),
            SizedBox(height: 16),
            _QuickActions(),
            SizedBox(height: 18),
            _InfoCard(
              children: [
                _InfoRow(
                  title: '新建联系人',
                  titleColor: iosBlue,
                  showChevron: false,
                ),
                _InfoRow(
                  title: '添加到现有联系人',
                  titleColor: iosBlue,
                  showChevron: false,
                ),
              ],
            ),
            SizedBox(height: 18),
            _AboutCard(),
            SizedBox(height: 18),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.photo_library_outlined,
                  title: '媒体、链接和文档',
                  trailingText: '0',
                ),
                _InfoRow(
                  icon: Icons.star_border_rounded,
                  title: '已加星标的消息',
                  trailingText: '无',
                ),
                _InfoRow(
                  icon: Icons.search_rounded,
                  title: '搜索',
                ),
              ],
            ),
            SizedBox(height: 18),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.notifications_none_rounded,
                  title: '静音',
                  trailing: _MutedSwitch(),
                  showChevron: false,
                ),
                _InfoRow(
                  icon: Icons.image_outlined,
                  title: '墙纸和声音',
                ),
                _InfoRow(
                  icon: Icons.download_outlined,
                  title: '保存到“照片”',
                  trailingText: '默认',
                ),
              ],
            ),
            SizedBox(height: 18),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.lock_outline_rounded,
                  title: '加密',
                  subtitle: '消息和通话已进行端到端加密。',
                ),
                _InfoRow(
                  icon: Icons.timer_outlined,
                  title: '消失的消息',
                  trailingText: '关闭',
                ),
                _InfoRow(
                  icon: Icons.lock_person_outlined,
                  title: '聊天锁定',
                  trailingText: '关闭',
                ),
              ],
            ),
            SizedBox(height: 18),
            _CommonGroupsCard(),
            SizedBox(height: 18),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.block_rounded,
                  title: '阻止联系人',
                  titleColor: Color(0xFFFF3B30),
                  iconColor: Color(0xFFFF3B30),
                  showChevron: false,
                ),
                _InfoRow(
                  icon: Icons.thumb_down_alt_outlined,
                  title: '举报联系人',
                  titleColor: Color(0xFFFF3B30),
                  iconColor: Color(0xFFFF3B30),
                  showChevron: false,
                ),
              ],
            ),
            SizedBox(height: 18),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.delete_outline_rounded,
                  title: '删除聊天',
                  titleColor: Color(0xFFFF3B30),
                  iconColor: Color(0xFFFF3B30),
                  showChevron: false,
                ),
              ],
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
    return const Column(
      children: [
        CircleAvatar(
          radius: 51,
          backgroundColor: Color(0xFFF4E7C9),
          child: Icon(
            Icons.person_rounded,
            color: Color(0xFFB78032),
            size: 52,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '+852 5923 9971',
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.35,
          ),
        ),
        SizedBox(height: 3),
        Text(
          '电话',
          style: TextStyle(color: iosSecondaryLabel, fontSize: 13),
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _QuickAction(
          icon: Icons.chat_bubble_rounded,
          label: '消息',
        ),
        _QuickAction(
          icon: Icons.call_outlined,
          label: '音频',
        ),
        _QuickAction(
          icon: Icons.videocam_outlined,
          label: '视频',
        ),
        _QuickAction(
          icon: Icons.search_rounded,
          label: '搜索',
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassSurface(
          borderRadius: 27,
          blur: 26,
          opacity: 0.56,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {},
              child: SizedBox(
                width: 52,
                height: 52,
                child: Icon(icon, color: iosBlue, size: 23),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: iosBlue, fontSize: 12),
        ),
      ],
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(15, 12, 15, 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '简介',
              style: TextStyle(color: iosSecondaryLabel, fontSize: 12),
            ),
            SizedBox(height: 5),
            Text(
              '嘿！我正在使用 WhatsApp。',
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var index = 0; index < children.length; index++) ...[
            children[index],
            if (index < children.length - 1)
              const Divider(indent: 49, color: dividerColor),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    this.icon,
    this.subtitle,
    this.trailingText,
    this.trailing,
    this.titleColor = textColor,
    this.iconColor = textColor,
    this.showChevron = true,
  });

  final IconData? icon;
  final String title;
  final String? subtitle;
  final String? trailingText;
  final Widget? trailing;
  final Color titleColor;
  final Color iconColor;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            if (icon != null) ...[
              SizedBox(
                width: 25,
                child: Icon(icon, color: iconColor, size: 19),
              ),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: iosSecondaryLabel,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (trailingText != null)
              Text(
                trailingText!,
                style: const TextStyle(
                  color: iosSecondaryLabel,
                  fontSize: 14,
                ),
              ),
            if (showChevron) ...[
              const SizedBox(width: 5),
              const Icon(
                Icons.chevron_right_rounded,
                color: iosSeparator,
                size: 21,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MutedSwitch extends StatelessWidget {
  const _MutedSwitch();

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: false,
      activeColor: primaryColor,
      onChanged: (_) {},
    );
  }
}

class _CommonGroupsCard extends StatelessWidget {
  const _CommonGroupsCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.fromLTRB(13, 11, 12, 11),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFE1F4E8),
                child: Icon(
                  Icons.groups_rounded,
                  color: primaryColor,
                  size: 23,
                ),
              ),
              SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '共同群组',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '没有共同群组',
                      style: TextStyle(
                        color: iosSecondaryLabel,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: iosSeparator,
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
