import 'package:flutter/material.dart';

import '../../../data/dummy_data.dart';
import '../../../data/model/chats_model.dart';
import '../../../utils/constants.dart';
import 'components/participate_tile.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({
    super.key,
  });

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = '全部';

  static const _filters = ['全部', '未读', '特别关注', '群组'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Participant> get _visibleChats {
    Iterable<Participant> chats = KDummyData.chatsList;

    switch (_selectedFilter) {
      case '未读':
        chats = chats.where((chat) => chat.unread > 0);
        break;
      case '特别关注':
        chats = chats.where((chat) => chat.id == 2);
        break;
      case '群组':
        chats = const <Participant>[];
        break;
    }

    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      chats = chats.where(
        (chat) =>
            chat.name.toLowerCase().contains(query) ||
            chat.lastMessage.toLowerCase().contains(query),
      );
    }

    return chats.toList();
  }

  @override
  Widget build(BuildContext context) {
    final chats = _visibleChats;

    return ListView(
      key: const PageStorageKey('conversation-list'),
      padding: const EdgeInsets.only(bottom: 118),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 12),
          child: TextField(
            key: const Key('chat-search-field'),
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: '搜索',
              isDense: true,
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: iosSecondaryLabel,
                size: 20,
              ),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: '清除',
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
            ),
          ),
        ),
        const _ContactAccessCard(),
        const SizedBox(height: 13),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filters.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 7),
            itemBuilder: (context, index) {
              if (index == _filters.length) {
                return Material(
                  color: Colors.white,
                  shape: const CircleBorder(
                    side: BorderSide(color: dividerColor),
                  ),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: const SizedBox(
                      width: 32,
                      height: 32,
                      child: Icon(
                        Icons.add_rounded,
                        color: iosSecondaryLabel,
                        size: 19,
                      ),
                    ),
                  ),
                );
              }
              final filter = _filters[index];
              return FilterChip(
                key: Key('filter-$filter'),
                label: Text(filter),
                selected: _selectedFilter == filter,
                showCheckmark: false,
                selectedColor: selectedNavColor,
                backgroundColor: scaffoldBgColor,
                side: BorderSide(
                  color: _selectedFilter == filter
                      ? const Color(0xFFA8E7B3)
                      : borderColor,
                ),
                shape: const StadiumBorder(),
                labelStyle: TextStyle(
                  color: _selectedFilter == filter
                      ? const Color(0xFF248449)
                      : iosSecondaryLabel,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                onSelected: (_) => setState(() => _selectedFilter = filter),
              );
            },
          ),
        ),
        const SizedBox(height: 9),
        if (chats.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 34),
            child: Column(
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 38,
                  color: iosSecondaryLabel,
                ),
                SizedBox(height: 10),
                Text(
                  '没有找到会话',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        else
          ...chats.map((chat) => ParticipateTile(element: chat)),
        const _LimitedContactsNotice(),
      ],
    );
  }
}

class _ContactAccessCard extends StatelessWidget {
  const _ContactAccessCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '允许完整联系人访问权限',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '除非你允许完整访问权限，否则无法找到你的所有亲朋好友。',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: iosSecondaryLabel,
              fontSize: 11,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 9),
          SizedBox(
            width: double.infinity,
            height: 29,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: const Color(0xFF20C56D),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('允许访问'),
            ),
          ),
        ],
      ),
    );
  }
}

class _LimitedContactsNotice extends StatelessWidget {
  const _LimitedContactsNotice();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(28, 19, 28, 0),
      child: Column(
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'WhatsApp 没有完整的联系人访问权限，因此部分姓名可能不会显示。 ',
              style: TextStyle(
                color: iosSecondaryLabel,
                fontSize: 11,
                height: 1.45,
              ),
              children: [
                TextSpan(
                  text: '允许访问权限',
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_rounded, size: 10, color: iosSecondaryLabel),
              SizedBox(width: 4),
              Text(
                '你的私人消息已进行端到端加密',
                style: TextStyle(color: iosSecondaryLabel, fontSize: 9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
