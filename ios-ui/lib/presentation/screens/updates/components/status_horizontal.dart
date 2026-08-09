import 'package:flutter/cupertino.dart';

import '../../../../data/dummy_data.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/k_images.dart';
import '../../../core/routes/routes_name.dart';

class StatusHorizontal extends StatelessWidget {
  const StatusHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '状态',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 166,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: KDummyData.storyList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const _MyStatusCard();
                }
                final story = KDummyData.storyList[index - 1];
                return _StatusCard(
                  image: story['avatar']!,
                  label: story['user']!.split(' ').first,
                  onTap: () =>
                      Navigator.of(context).pushNamed(RouteNames.storyPage),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MyStatusCard extends StatelessWidget {
  const _MyStatusCard();

  @override
  Widget build(BuildContext context) {
    return _StatusCard(
      image: KImages.chatAvatar1,
      label: '我的状态',
      isMine: true,
      onTap: () {},
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.image,
    required this.label,
    required this.onTap,
    this.isMine = false,
  });

  final String image;
  final String label;
  final VoidCallback onTap;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: 104,
            height: 166,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(image, fit: BoxFit.cover),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x1A000000),
                        Color(0xB8000000),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 8,
                  bottom: 10,
                  child: Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isMine)
                  const Positioned(
                    top: 10,
                    left: 10,
                    child: Icon(
                      CupertinoIcons.plus_circle_fill,
                      color: actionGreen,
                      size: 28,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
