import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../data/dummy_data.dart';
import '../../../data/model/participants_chat_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import 'components/appbar_component.dart';
import 'components/inbox_popup.dart';
import 'components/input_text_emoji.dart';
import 'components/message_item.dart';
import 'controller/message_controller.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = KDummyData.participantsChat;

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        appBar: _buildAppBar(user),
        body: DecoratedBox(
          decoration: _decoration(),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: MessageController.streamData,
                    initialData: MessageController.list,
                    builder: (context, snapshot) {
                      final messages = snapshot.data ?? user.messages;
                      if (messages.isNotEmpty) {
                        final messageList = messages.toList();
                        return GroupedListView<Messages, DateTime>(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
                          elements: messageList,
                          groupBy: (element) => DateTime(
                            element.date.year,
                            element.date.month,
                            element.date.day,
                          ),
                          groupSeparatorBuilder: (DateTime groupByValue) =>
                              MessageSeparator(groupByValue: groupByValue),
                          itemBuilder: (context, Messages element) =>
                              MessageComponent(element: element),
                          itemComparator: (item1, item2) =>
                              item1.date.compareTo(item2.date),
                          useStickyGroupSeparators: false,
                          floatingHeader: true,
                          order: GroupedListOrder.ASC,
                        );
                      }
                      return const SizedBox();
                    }),
              ),
              const TextEmojiInputField(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(ParticipantsChat user) {
    return AppBar(
      toolbarHeight: 62,
      leadingWidth: 88,
      leading: AvatarAndBackNavigate(user: user),
      title: UserAndStatus(user: user),
      titleSpacing: 4,
      actions: [
        IconButton(
          tooltip: 'Video call',
          onPressed: () {},
          icon: const Icon(Icons.videocam_outlined, color: textColor),
        ),
        IconButton(
          tooltip: 'Voice call',
          onPressed: () {},
          icon: const Icon(Icons.call_outlined, color: textColor),
        ),
        const InboxPopup(),
        const SizedBox(width: 2),
      ],
    );
  }

  BoxDecoration _decoration() {
    return const BoxDecoration(
      color: Color(0xFFEFEAE2),
      image: DecorationImage(
        image: AssetImage(KImages.defaultWallpaper),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Color(0x24FFFFFF),
          BlendMode.srcATop,
        ),
      ),
    );
  }
}
