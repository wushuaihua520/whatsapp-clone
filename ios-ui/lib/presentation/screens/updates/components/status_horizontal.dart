import 'package:flutter/material.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: hTextColor,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  tooltip: 'Status options',
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: textColor,
                  ),
                  offset: const Offset(0, 35),
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'Muted updates',
                      child: Text('Muted updates'),
                    ),
                    PopupMenuItem(
                      value: 'Status privacy',
                      child: Text('Status privacy'),
                    ),
                  ],
                ),
              ],
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
                return Story(index: index - 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Story extends StatelessWidget {
  const Story({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    final story = KDummyData.storyList[index];
    return _StatusCard(
      image: story['avatar']!,
      label: story['user']!.split(' ').first,
      onTap: () => Navigator.pushNamed(context, RouteNames.storyPage),
    );
  }
}

class _MyStatusCard extends StatelessWidget {
  const _MyStatusCard();

  @override
  Widget build(BuildContext context) {
    return _StatusCard(
      image: KImages.chatAvatar1,
      label: 'My status',
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
      child: Material(
        color: searchFieldColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 104,
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
                        Color(0x14000000),
                        Color(0xB8000000),
                      ],
                      stops: [0, 0.52, 1],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    width: 38,
                    height: 38,
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: isMine ? Colors.white : actionGreen,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(image),
                    ),
                  ),
                ),
                if (isMine)
                  Positioned(
                    top: 32,
                    left: 34,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: actionGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        color: blackColor,
                        size: 14,
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
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(color: Colors.black45, blurRadius: 4),
                      ],
                    ),
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
