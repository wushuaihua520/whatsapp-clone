import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../data/dummy_data.dart';
import '../../../data/model/participants_chat_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/strings.dart';
import 'components/input_text_emoji.dart';
import 'components/message_item.dart';
import 'controller/message_controller.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure messages are available when opening inbox directly.
    if (MessageController.list.isEmpty) {
      MessageController.init();
    }
    final size = MediaQuery.of(context).size;
    final user = KDummyData.participantsChat;
    final top = MediaQuery.of(context).padding.top;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: chatWallpaperBg,
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: chatWallpaperBg,
            image: DecorationImage(
              image: AssetImage(KImages.defaultWallpaper),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withValues(alpha: 0.35),
                BlendMode.lighten,
              ),
            ),
          ),
          child: Column(
            children: [
              _IosChatNavBar(user: user, top: top),
              Expanded(
                child: StreamBuilder<List<Messages>>(
                  stream: MessageController.streamData,
                  initialData: MessageController.list,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null || data.isEmpty) {
                      return const SizedBox();
                    }
                    final messageList = data.reversed.toList();
                    return GroupedListView<Messages, DateTime>(
                      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                      elements: messageList,
                      groupBy: (element) => DateTime(
                        element.date.year,
                        element.date.month,
                        element.date.day,
                      ),
                      groupSeparatorBuilder: (DateTime groupByValue) => Column(
                        children: [
                          MessageSeparator(groupByValue: groupByValue),
                          if (_isFirstGroup(messageList, groupByValue))
                            const _EncryptionBanner(),
                        ],
                      ),
                      itemBuilder: (context, Messages element) =>
                          MessageComponent(
                        element: element,
                        messages: messageList,
                      ),
                      itemComparator: (item1, item2) =>
                          item1.date.compareTo(item2.date),
                      useStickyGroupSeparators: false,
                      floatingHeader: true,
                      order: GroupedListOrder.ASC,
                    );
                  },
                ),
              ),
              const TextEmojiInputField(),
            ],
          ),
        ),
      ),
    );
  }

  bool _isFirstGroup(List<Messages> list, DateTime group) {
    if (list.isEmpty) return false;
    final first = list.reduce((a, b) => a.date.isBefore(b.date) ? a : b);
    return first.date.year == group.year &&
        first.date.month == group.month &&
        first.date.day == group.day;
  }
}

class _IosChatNavBar extends StatelessWidget {
  const _IosChatNavBar({required this.user, required this.top});
  final ParticipantsChat user;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE5E5EA), width: 0.5),
        ),
      ),
      child: SizedBox(
        height: 52,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  CupertinoIcons.back,
                  size: 28,
                  color: Color(0xFF007AFF),
                ),
              ),
              SizedBox(width: 2.w),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: user.usePlaceholder
                      ? const Color(0xFFF5B27A)
                      : searchBarBg,
                  image: !user.usePlaceholder && user.avatar.isNotEmpty
                      ? DecorationImage(
                          image: AssetImage(user.avatar),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: user.usePlaceholder
                    ? Icon(
                        CupertinoIcons.person_fill,
                        size: 18,
                        color: Colors.white.withValues(alpha: 0.95),
                      )
                    : null,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  user.participant,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              Container(
                height: 36,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E8ED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.videocam_fill,
                        size: 22.sp, color: Colors.black),
                    SizedBox(width: 16.w),
                    Icon(CupertinoIcons.phone_fill,
                        size: 18.sp, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EncryptionBanner extends StatelessWidget {
  const _EncryptionBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(28.w, 4.h, 28.w, 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: encryptionBannerBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Icon(CupertinoIcons.lock_fill,
                size: 11.sp, color: const Color(0xFF5A5A5A)),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              KStrings.encryptionNotice,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF5A5A5A),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageSeparator extends StatelessWidget {
  const MessageSeparator({
    super.key,
    required this.groupByValue,
  });
  final DateTime groupByValue;

  @override
  Widget build(BuildContext context) {
    final label = DateFormat('yyyy年M月d日').format(groupByValue);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: dateChipBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: const Color(0xFF5A5A5A),
          ),
        ),
      ),
    );
  }
}
