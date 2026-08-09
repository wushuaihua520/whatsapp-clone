import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('community-list'),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
      children: [
        const _NewCommunityTile(),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Image.asset(
                KImages.communityImg,
                height: 132,
                fit: BoxFit.contain,
              ),
              const Text(
                '将群组集中在一起',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: hTextColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '把相关群组放在同一处，并用公告消息触达每一位成员。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: iosSecondaryLabel,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('开始创建社区'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '你的社区',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: hTextColor,
          ),
        ),
        const SizedBox(height: 12),
        const _CommunityCard(),
      ],
    );
  }
}

class _NewCommunityTile extends StatelessWidget {
  const _NewCommunityTile();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scaffoldBgColor,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: Color(0xFFD5DADD),
                    child: Icon(
                      Icons.groups_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    right: -3,
                    bottom: -2,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: actionGreen,
                      child: Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 14),
              Text(
                '新建社区',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const _CommunityRow(
            icon: Icons.palette_outlined,
            iconColor: Color(0xFF6C63FF),
            iconBackground: Color(0xFFE9E7FF),
            title: '设计圈',
            subtitle: '3 个群组',
            isHeader: true,
          ),
          const Divider(height: 1),
          const _CommunityRow(
            icon: Icons.campaign_rounded,
            iconColor: primaryColor,
            iconBackground: selectedNavColor,
            title: '公告',
            subtitle: 'Maya：欢迎加入社区！',
          ),
          const Divider(height: 1, indent: 70),
          const _CommunityRow(
            icon: Icons.forum_outlined,
            iconColor: Color(0xFF6A4C93),
            iconBackground: Color(0xFFEDE4F5),
            title: '综合讨论',
            subtitle: 'Philip：分享了一张照片',
            unread: 4,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: iosBlue),
              child: const Text('查看全部'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunityRow extends StatelessWidget {
  const _CommunityRow({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    this.unread = 0,
    this.isHeader = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final int unread;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: isHeader ? 50 : 44,
              height: isHeader ? 50 : 44,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(isHeader ? 14 : 12),
              ),
              child: Icon(icon, color: iconColor, size: isHeader ? 27 : 23),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: isHeader ? 16 : 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: iosSecondaryLabel,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (unread > 0)
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFF25D366),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unread.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
