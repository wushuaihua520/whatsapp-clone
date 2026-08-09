import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/strings.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_button.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: top + 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                KStrings.communities,
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            Utils.verticalSpace(20),
            Image.asset(KImages.communityImg),
            FittedBox(
              child: Text(
                KStrings.communityTitleText,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: hTextColor,
                ),
              ),
            ),
            Utils.verticalSpace(10),
            Text(
              KStrings.communityParagraphText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: subTitleTextColor,
              ),
            ),
            Utils.verticalSpace(10),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios, size: 14.sp, color: primaryColor),
                label: Text(
                  KStrings.communityExampleText,
                  style: TextStyle(color: primaryColor, fontSize: 14.sp),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              text: KStrings.communityStartText,
              press: () {},
            ),
            Utils.verticalSpace(30),
          ],
        ),
      ),
    );
  }
}
