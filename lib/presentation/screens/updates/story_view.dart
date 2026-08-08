import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';

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
          caption: "Beautiful lake view",
          controller: storyController),
    ]; //
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        leadingWidth: 76,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8),
              const Icon(Icons.arrow_back_rounded, color: Colors.white),
              const SizedBox(width: 7),
              const CircleAvatar(
                radius: 17,
                backgroundImage: AssetImage(KImages.chatAvatar1),
              ),
            ],
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Martin Luther",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "Yesterday, 2:44 PM",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
              offset: const Offset(0, 50),
              padding: EdgeInsets.zero,
              itemBuilder: (context) {
                return const <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'mute',
                    child: Text('Mute'),
                  ),
                  PopupMenuItem<String>(
                    value: 'message',
                    child: Text('Message'),
                  ),
                  PopupMenuItem<String>(
                    value: 'call',
                    child: Text('Voice call'),
                  ),
                  PopupMenuItem<String>(
                    value: 'contact',
                    child: Text('View contact'),
                  ),
                  PopupMenuItem<String>(
                    value: 'report',
                    child: Text('Report'),
                  ),
                ];
              })
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: StoryView(
        controller: storyController, // pass controller here too
        repeat: true, // should the stories be slid forever
        onStoryShow: (s) {},
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
