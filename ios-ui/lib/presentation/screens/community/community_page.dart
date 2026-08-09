import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('community-list'),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      children: [
        const _NewCommunityTile(),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          decoration: BoxDecoration(
            color: searchFieldColor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              Image.asset(
                KImages.communityImg,
                height: 132,
                fit: BoxFit.contain,
              ),
              const Text(
                'Bring your groups together',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: hTextColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Organize related groups in one place and reach everyone '
                'with announcement messages.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: subTitleTextColor,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Start your community'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Your communities',
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
                        color: blackColor,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 14),
              Text(
                'New community',
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
        border: Border.all(color: dividerColor),
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const _CommunityRow(
            icon: Icons.palette_outlined,
            iconColor: Color(0xFF6C63FF),
            iconBackground: Color(0xFFE9E7FF),
            title: 'Design Circle',
            subtitle: '3 groups',
            isHeader: true,
          ),
          const Divider(),
          const _CommunityRow(
            icon: Icons.campaign_rounded,
            iconColor: primaryColor,
            iconBackground: selectedNavColor,
            title: 'Announcements',
            subtitle: 'Maya: Welcome to the community!',
          ),
          const Divider(indent: 70),
          const _CommunityRow(
            icon: Icons.forum_outlined,
            iconColor: Color(0xFF6A4C93),
            iconBackground: Color(0xFFEDE4F5),
            title: 'General',
            subtitle: 'Philip: Shared a photo',
            unread: 4,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right_rounded, size: 20),
              label: const Text('View all'),
              style: TextButton.styleFrom(foregroundColor: primaryColor),
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
                      color: subTitleTextColor,
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
                  color: actionGreen,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unread.toString(),
                  style: const TextStyle(
                    color: blackColor,
                    fontSize: 10,
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
