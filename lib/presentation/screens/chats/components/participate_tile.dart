import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/model/chats_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/k_images.dart';
import '../../../core/routes/routes_name.dart';

class ParticipateTile extends StatelessWidget {
  const ParticipateTile({
    super.key,
    required this.element,
  });

  final Participant element;

  @override
  Widget build(BuildContext context) {
    final isOfficial = element.name == 'WhatsApp';
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.inbox);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, right: 12.w),
              child: _Avatar(element: element, isOfficial: isOfficial),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 12.h, right: 16.w, bottom: 12.h),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE5E5EA), width: 0.5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            element.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.black,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        Text(
                          element.dateLabel ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: secondaryLabel,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        if (element.isVideoPreview) ...[
                          Icon(CupertinoIcons.videocam_fill,
                              size: 16.sp, color: secondaryLabel),
                          SizedBox(width: 4.w),
                        ],
                        Expanded(
                          child: Text(
                            element.lastMessage,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.5.sp,
                              color: secondaryLabel,
                              height: 1.25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.element, required this.isOfficial});
  final Participant element;
  final bool isOfficial;

  @override
  Widget build(BuildContext context) {
    if (isOfficial) {
      return Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            KImages.logo,
            width: 32,
            height: 32,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.chat,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      );
    }
    if (element.usePlaceholderAvatar) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: element.placeholderColor ?? const Color(0xFFF5B27A),
          shape: BoxShape.circle,
        ),
        child: Icon(
          CupertinoIcons.person_fill,
          color: Colors.white.withValues(alpha: 0.95),
          size: 32,
        ),
      );
    }
    return CircleAvatar(
      radius: 28,
      backgroundColor: searchBarBg,
      backgroundImage: AssetImage(element.avatar),
    );
  }
}
