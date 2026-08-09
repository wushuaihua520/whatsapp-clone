import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';
import '../../../utils/strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return ColoredBox(
      color: settingsBgColor,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: top + 8)),
          const SliverToBoxAdapter(child: _ProfileTopActions()),
          SliverToBoxAdapter(child: SizedBox(height: 18.h)),
          const SliverToBoxAdapter(child: _ProfileHero()),
          SliverToBoxAdapter(child: SizedBox(height: 28.h)),
          SliverToBoxAdapter(
            child: _SettingsGroup(
              items: const [
                _SettingItem(
                  icon: CupertinoIcons.person_crop_rectangle,
                  iconBg: Color(0xFF34C759),
                  labelKey: 'list',
                ),
                _SettingItem(
                  icon: CupertinoIcons.star_fill,
                  iconBg: Color(0xFFFFCC00),
                  labelKey: 'starred',
                ),
                _SettingItem(
                  icon: CupertinoIcons.speaker_2_fill,
                  iconBg: Color(0xFFFF9500),
                  labelKey: 'broadcast',
                ),
                _SettingItem(
                  icon: CupertinoIcons.desktopcomputer,
                  iconBg: Color(0xFF5AC8FA),
                  labelKey: 'linked',
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 18.h)),
          SliverToBoxAdapter(
            child: _SettingsGroup(
              items: const [
                _SettingItem(
                  icon: Icons.vpn_key_rounded,
                  iconBg: Color(0xFF007AFF),
                  labelKey: 'account',
                  useKeyIcon: true,
                ),
                _SettingItem(
                  icon: CupertinoIcons.lock_fill,
                  iconBg: Color(0xFF34C759),
                  labelKey: 'privacy',
                ),
                _SettingItem(
                  icon: CupertinoIcons.chat_bubble_fill,
                  iconBg: Color(0xFF34C759),
                  labelKey: 'chat',
                ),
                _SettingItem(
                  icon: CupertinoIcons.bell_fill,
                  iconBg: Color(0xFFFF3B30),
                  labelKey: 'notifications',
                ),
                _SettingItem(
                  icon: CupertinoIcons.arrow_up_arrow_down_circle_fill,
                  iconBg: Color(0xFF007AFF),
                  labelKey: 'storage',
                ),
              ],
            ),
          ),
          // Extra space so last group clears floating tab bar
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }
}

class _ProfileTopActions extends StatelessWidget {
  const _ProfileTopActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _RoundAction(
            child: Icon(CupertinoIcons.search, size: 20.sp),
          ),
          const Spacer(),
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(CupertinoIcons.qrcode, size: 18.sp),
                SizedBox(width: 14.w),
                Icon(CupertinoIcons.pencil, size: 18.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 118,
          width: 118,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                  color: avatarMint,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.person_fill,
                  size: 64,
                  color: Colors.black.withValues(alpha: 0.45),
                ),
              ),
              Positioned(
                top: -2,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    KStrings.latestUpdates,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              KStrings.profileName,
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.4,
              ),
            ),
            SizedBox(width: 6.w),
            Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: secondaryLabel, width: 1.2),
              ),
              child: Text(
                '♂',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: secondaryLabel,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SettingItem {
  const _SettingItem({
    required this.icon,
    required this.iconBg,
    required this.labelKey,
    this.useKeyIcon = false,
  });

  final IconData icon;
  final Color iconBg;
  final String labelKey;
  final bool useKeyIcon;

  String get label {
    switch (labelKey) {
      case 'list':
        return KStrings.list;
      case 'starred':
        return KStrings.starred;
      case 'broadcast':
        return KStrings.broadcast;
      case 'linked':
        return KStrings.linkedDevices;
      case 'account':
        return KStrings.account;
      case 'privacy':
        return KStrings.privacy;
      case 'chat':
        return KStrings.chat;
      case 'notifications':
        return KStrings.notifications;
      case 'storage':
        return KStrings.storageData;
      default:
        return '';
    }
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.items});
  final List<_SettingItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: List.generate(items.length, (i) {
            final item = items[i];
            final isLast = i == items.length - 1;
            return Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: item.iconBg,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          item.labelKey == 'account'
                              ? Icons.vpn_key_rounded
                              : item.icon,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_forward,
                        size: 16.sp,
                        color: tertiaryLabel,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Padding(
                    padding: EdgeInsets.only(left: 56.w),
                    child: const Divider(
                      height: 0.5,
                      thickness: 0.5,
                      color: Color(0xFFE5E5EA),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
