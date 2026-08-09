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
          padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
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
        SizedBox(
          height: 34,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filters.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == _filters.length) {
                return _IosFilterAddButton(onTap: () {});
              }
              final filter = _filters[index];
              final selected = _selectedFilter == filter;
              return _IosFilterChip(
                key: Key('filter-$filter'),
                label: filter,
                selected: selected,
                onTap: () => setState(() => _selectedFilter = filter),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
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

class _IosFilterChip extends StatelessWidget {
  const _IosFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE7F8EC) : const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF1A7F37) : iosSecondaryLabel,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _IosFilterAddButton extends StatelessWidget {
  const _IosFilterAddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F7),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add_rounded,
          color: iosSecondaryLabel,
          size: 18,
        ),
      ),
    );
  }
}

class _LimitedContactsNotice extends StatelessWidget {
  const _LimitedContactsNotice();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(28, 22, 28, 0),
      child: Column(
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'WhatsApp 没有完整的联系人访问权限，因此部分姓名可能不会显示。 ',
              style: TextStyle(
                color: iosSecondaryLabel,
                fontSize: 12,
                height: 1.45,
              ),
              children: [
                TextSpan(
                  text: '允许访问权限',
                  style: TextStyle(color: iosBlue),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_rounded, size: 11, color: iosSecondaryLabel),
              SizedBox(width: 4),
              Text(
                '你的私人消息已进行端到端加密',
                style: TextStyle(color: iosSecondaryLabel, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
