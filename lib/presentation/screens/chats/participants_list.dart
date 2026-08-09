import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/dummy_data.dart';
import '../../../utils/constants.dart';
import '../../../utils/strings.dart';
import 'components/participate_tile.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({super.key});

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  int filterIndex = 0;
  final filters = [
    KStrings.all,
    KStrings.unread,
    KStrings.favorites,
    KStrings.groups,
  ];

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
          const SliverToBoxAdapter(child: _ChatHeaderActions()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: Text(
                KStrings.chats,
                style: TextStyle(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 0.4,
                  height: 1.1,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
              child: const _SearchField(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
              child: const _ContactPermissionCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 8.w, 0),
              child: _FilterRow(
                filters: filters,
                selected: filterIndex,
                onSelect: (i) => setState(() => filterIndex = i),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final element = KDummyData.chatsList[index];
                return ParticipateTile(element: element);
              },
              childCount: KDummyData.chatsList.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28.w, 16.h, 28.w, 8.h),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: secondaryLabel,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(text: KStrings.contactPermissionFooter),
                    TextSpan(
                      text: KStrings.allowAccessLink,
                      style: TextStyle(
                        color: linkGreen,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 100.h, top: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.lock_fill,
                      size: 11.sp, color: secondaryLabel),
                  SizedBox(width: 4.w),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: secondaryLabel,
                      ),
                      children: [
                        TextSpan(text: KStrings.e2eEncrypted),
                        TextSpan(
                          text: KStrings.e2eEncryptedHighlight,
                          style: TextStyle(
                            color: linkGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatHeaderActions extends StatelessWidget {
  const _ChatHeaderActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: searchBarBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.ellipsis, size: 18),
          ),
          const Spacer(),
          Icon(CupertinoIcons.camera, size: 24.sp, color: Colors.black),
          SizedBox(width: 16.w),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.plus, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        color: searchBarBg,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          Icon(CupertinoIcons.search, size: 18.sp, color: secondaryLabel),
          SizedBox(width: 6.w),
          Text(
            KStrings.search,
            style: TextStyle(
              fontSize: 16.sp,
              color: secondaryLabel,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactPermissionCard extends StatelessWidget {
  const _ContactPermissionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E5EA), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            KStrings.contactPermissionTitle,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            KStrings.contactPermissionBody,
            style: TextStyle(
              fontSize: 13.sp,
              color: secondaryLabel,
              height: 1.35,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: Text(
                KStrings.allowAccess,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({
    required this.filters,
    required this.selected,
    required this.onSelect,
  });

  final List<String> filters;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(filters.length, (i) {
            final active = selected == i;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () => onSelect(i),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: active ? primaryColor : filterInactiveBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    filters[i],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: active ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: filterInactiveBg,
              shape: BoxShape.circle,
            ),
            child: Icon(CupertinoIcons.plus, size: 16.sp, color: secondaryLabel),
          ),
        ],
      ),
    );
  }
}
