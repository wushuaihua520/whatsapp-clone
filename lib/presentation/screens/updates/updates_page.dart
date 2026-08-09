import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';
import '../../../utils/strings.dart';
import 'components/channels_list.dart';
import 'components/status_horizontal.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

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
              child: Row(
                children: [
                  Text(
                    KStrings.updates,
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Icon(CupertinoIcons.search, size: 22.sp),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: StatusHorizontal()),
          const SliverToBoxAdapter(
            child: Divider(color: separatorColor, height: 1),
          ),
          const SliverToBoxAdapter(child: ChannelsList()),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        ],
      ),
    );
  }
}
