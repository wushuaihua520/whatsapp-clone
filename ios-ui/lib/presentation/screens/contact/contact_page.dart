import 'package:flutter/cupertino.dart';

import '../../../data/dummy_data.dart';
import '../../../utils/constants.dart';
import '../../core/routes/routes_name.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          onPressed: () => Navigator.pop(context),
          child: const Text(
            '取消',
            style: TextStyle(color: iosBlue, fontSize: 17),
          ),
        ),
        middle: const Text('新聊天'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          onPressed: () {},
          child: const Icon(CupertinoIcons.qrcode, color: iosBlue),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: CupertinoSearchTextField(
              placeholder: '搜索姓名或号码',
            ),
          ),
          CupertinoListSection.insetGrouped(
            children: [
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.person_2),
                title: const Text('新建群组'),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.person_add),
                title: const Text('新建联系人'),
                trailing: const CupertinoListTileChevron(),
                onTap: () {},
              ),
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.person_3),
                title: const Text('新建社区'),
                onTap: () {},
              ),
            ],
          ),
          CupertinoListSection.insetGrouped(
            header: const Text('联系人'),
            children: [
              for (final contact in KDummyData.contacts)
                CupertinoListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(contact['avatar']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(contact['user']!),
                  onTap: () =>
                      Navigator.of(context).pushNamed(RouteNames.inbox),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
