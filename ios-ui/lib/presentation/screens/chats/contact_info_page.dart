import 'package:flutter/cupertino.dart';

import '../../../utils/constants.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: iosGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xF7F9F9F9),
        border: null,
        middle: const Text('联系人信息'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          onPressed: () {},
          child: const Text(
            '编辑',
            style: TextStyle(color: iosBlue, fontSize: 17),
          ),
        ),
      ),
      child: ListView(
        key: const Key('ios-contact-info-list'),
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: Color(0xFFF4E7C9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.person_fill,
                color: Color(0xFFB78032),
                size: 48,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              '+852 5923 9971',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
          ),
          const Center(
            child: Text(
              '电话',
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                for (final item in const [
                  (CupertinoIcons.chat_bubble, '消息'),
                  (CupertinoIcons.phone, '音频'),
                  (CupertinoIcons.videocam, '视频'),
                  (CupertinoIcons.search, '搜索'),
                ])
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(item.$1, color: iosBlue, size: 22),
                            const SizedBox(height: 4),
                            Text(
                              item.$2,
                              style: const TextStyle(
                                color: iosBlue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          CupertinoListSection.insetGrouped(
            header: null,
            children: const [
              CupertinoListTile(
                title: Text('新建联系人', style: TextStyle(color: iosBlue)),
              ),
              CupertinoListTile(
                title: Text('添加到现有联系人', style: TextStyle(color: iosBlue)),
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: const [
              CupertinoListTile(
                title: Text('简介'),
                subtitle: Text('嘿！我正在使用 WhatsApp.'),
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: const [
              CupertinoListTile(
                title: Text('媒体、链接和文档'),
                additionalInfo: Text('0'),
                trailing: CupertinoListTileChevron(),
              ),
              CupertinoListTile(
                title: Text('已加星标的消息'),
                additionalInfo: Text('无'),
                trailing: CupertinoListTileChevron(),
              ),
              CupertinoListTile(
                title: Text('搜索'),
                trailing: CupertinoListTileChevron(),
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile(
                title: const Text('静音'),
                trailing: CupertinoSwitch(value: false, onChanged: (_) {}),
              ),
              const CupertinoListTile(
                title: Text('墙纸和声音'),
                trailing: CupertinoListTileChevron(),
              ),
              const CupertinoListTile(
                title: Text('保存到"照片"'),
                additionalInfo: Text('默认'),
                trailing: CupertinoListTileChevron(),
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: const [
              CupertinoListTile(
                title: Text('加密'),
                subtitle: Text('消息和通话已进行端到端加密。'),
                trailing: CupertinoListTileChevron(),
              ),
              CupertinoListTile(
                title: Text('消失的消息'),
                additionalInfo: Text('关闭'),
                trailing: CupertinoListTileChevron(),
              ),
              CupertinoListTile(
                title: Text('聊天锁定'),
                additionalInfo: Text('关闭'),
                trailing: CupertinoListTileChevron(),
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: const [
              CupertinoListTile(
                title: Text('共同群组'),
                subtitle: Text('没有共同群组'),
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            children: const [
              CupertinoListTile(
                title: Text(
                  '阻止联系人',
                  style: TextStyle(color: CupertinoColors.destructiveRed),
                ),
              ),
              CupertinoListTile(
                title: Text(
                  '举报联系人',
                  style: TextStyle(color: CupertinoColors.destructiveRed),
                ),
              ),
              CupertinoListTile(
                title: Text(
                  '删除聊天',
                  style: TextStyle(color: CupertinoColors.destructiveRed),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
