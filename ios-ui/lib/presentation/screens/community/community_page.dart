import 'package:flutter/cupertino.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: scaffoldBgColor,
      child: CustomScrollView(
        key: const PageStorageKey('community-list'),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('社区', key: Key('ios-社区-title')),
            backgroundColor: const Color(0xF7F9F9F9),
            border: null,
            transitionBetweenRoutes: false,
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: () {},
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5E5EA),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.ellipsis,
                  size: 18,
                  color: textColor,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey5.resolveFrom(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      CupertinoIcons.person_3_fill,
                      color: textColor,
                    ),
                  ),
                  title: const Text('新建社区'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6.resolveFrom(context),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      KImages.communityImg,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    const Text(
                      '将群组集中在一起',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '把相关群组放在同一处，并用公告消息触达每一位成员。',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(22),
                        onPressed: () {},
                        child: const Text(
                          '开始创建社区',
                          style: TextStyle(color: CupertinoColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
    );
  }
}
