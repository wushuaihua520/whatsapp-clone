import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_view/story_view.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';

import '../../../utils/utils.dart';

class MyStoryPage extends StatelessWidget {
  MyStoryPage({super.key});

  final storyController = StoryController();

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [
      StoryItem.text(
          title: "Hi, this is my story", backgroundColor: blackColor),
      StoryItem.pageImage(
          url:
              "https://t3.ftcdn.net/jpg/05/68/52/52/360_F_568525285_CrGJ8Yh1noTyqu6QsocfVeGQGY91E0Jb.jpg",
          controller: storyController),
      StoryItem.pageImage(
          url:
              "https://www.itl.cat/pngfile/big/54-545287_beautiful-landscape-backgrounds-landscape-wallpapers-british-columbia.jpg",
          caption: const Text(
            "Beautiful lake view",
            style: TextStyle(color: Colors.white),
          ),
          controller: storyController),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 75.w,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Utils.horizontalSpace(6.w),
              Icon(kIsWeb ? Icons.arrow_back_ios : Icons.arrow_back_ios),
              Utils.horizontalSpace(6.w),
              CircleAvatar(backgroundImage: AssetImage(KImages.chatAvatar1)),
            ],
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Martin Luther",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Utils.verticalSpace(3),
            Text(
              "Yesterday, 2:44 PM",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              offset: const Offset(0, 50),
              color: scaffoldBgColor,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.zero,
              itemBuilder: (context) {
                return <PopupMenuEntry>[
                  const PopupMenuItem(child: Text("Mute")),
                  const PopupMenuItem(child: Text("Message")),
                  const PopupMenuItem(child: Text("Voice call")),
                  const PopupMenuItem(child: Text("View contact")),
                  const PopupMenuItem(child: Text("Report")),
                ];
              })
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: StoryView(
        controller: storyController,
        repeat: true,
        onStoryShow: (s, _) {},
        inline: true,
        progressPosition: ProgressPosition.top,
        onComplete: () {},
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        },
        storyItems: storyItems,
      ),
    );
  }
}
