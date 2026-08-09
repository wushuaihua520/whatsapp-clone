import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/dummy_data.dart';
import '../../../utils/constants.dart';
import '../../../utils/strings.dart';
import '../../../data/model/call_log_model.dart';

class CallLogs extends StatelessWidget {
  const CallLogs({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return ColoredBox(
      color: Colors.white,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: top + 8)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                KStrings.calls,
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: searchBarBg,
                child: Icon(
                  CupertinoIcons.link,
                  color: primaryColor,
                  size: 22.sp,
                ),
              ),
              title: Text(
                "创建通话链接",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "分享链接以发起 WhatsApp 通话",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: secondaryLabel,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
              child: Text(
                "最近",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final log = KDummyData.callHistory[index];
                return _CallTile(log: log);
              },
              childCount: KDummyData.callHistory.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _CallTile extends StatelessWidget {
  const _CallTile({required this.log});
  final CallLog log;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: AssetImage(log.avatar),
      ),
      title: Text(
        log.personName,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: log.isMissed ? Colors.red : Colors.black,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            log.incoming
                ? CupertinoIcons.arrow_down_left
                : CupertinoIcons.arrow_up_right,
            size: 14.sp,
            color: log.isMissed ? Colors.red : secondaryLabel,
          ),
          SizedBox(width: 4.w),
          Text(
            log.time,
            style: TextStyle(fontSize: 13.sp, color: secondaryLabel),
          ),
        ],
      ),
      trailing: Icon(
        log.callType.toLowerCase() == 'video'
            ? CupertinoIcons.videocam
            : CupertinoIcons.phone,
        color: primaryColor,
      ),
    );
  }
}
