import 'package:flutter/cupertino.dart';
import 'package:story_view/story_view.dart';

import '../../../utils/constants.dart';

class MyStoryPage extends StatelessWidget {
  MyStoryPage({super.key});

  final storyController = StoryController();

  @override
  Widget build(BuildContext context) {
    final storyItems = [
      StoryItem.text(
        title: 'Hi, this is my story',
        backgroundColor: blackColor,
      ),
      StoryItem.pageImage(
        url:
            'https://t3.ftcdn.net/jpg/05/68/52/52/360_F_568525285_CrGJ8Yh1noTyqu6QsocfVeGQGY91E0Jb.jpg',
        controller: storyController,
      ),
    ];

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: const Color(0x66000000),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          onPressed: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.xmark,
            color: CupertinoColors.white,
          ),
        ),
      ),
      child: StoryView(
        storyItems: storyItems,
        controller: storyController,
        onComplete: () => Navigator.pop(context),
      ),
    );
  }
}
