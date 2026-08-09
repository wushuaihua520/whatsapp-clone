import 'package:flutter/cupertino.dart';

import '../../../data/dummy_data.dart';
import '../../../utils/constants.dart';
import '../../../data/model/call_log_model.dart';

class CallLogs extends StatelessWidget {
  const CallLogs({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: scaffoldBgColor,
      child: CustomScrollView(
        key: const PageStorageKey('calls-list'),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('通话', key: Key('ios-通话-title')),
            backgroundColor: const Color(0xF7F9F9F9),
            border: null,
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: () {},
              child: const Icon(CupertinoIcons.phone_fill),
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              header: const Text('特别关注'),
              children: [
                for (final contact in KDummyData.contacts.take(4))
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
                    title: Text(contact['user']!.split(' ').first),
                    trailing: const Icon(CupertinoIcons.phone, color: iosBlue),
                  ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              header: const Text('最近'),
              children: [
                for (final call in KDummyData.callHistory)
                  _CallTile(call: call),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CallTile extends StatelessWidget {
  const _CallTile({required this.call});

  final CallLog call;

  @override
  Widget build(BuildContext context) {
    final isVideo = call.callType.toLowerCase() == 'video';
    return CupertinoListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(call.avatar),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        call.personName,
        style: TextStyle(
          color: call.isMissed ? CupertinoColors.destructiveRed : textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(call.time),
      trailing: Icon(
        isVideo ? CupertinoIcons.videocam : CupertinoIcons.phone,
        color: iosBlue,
      ),
    );
  }
}
