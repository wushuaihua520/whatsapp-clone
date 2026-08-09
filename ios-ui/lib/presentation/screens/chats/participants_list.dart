import 'package:flutter/cupertino.dart';
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
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CupertinoSearchTextField(
            key: const Key('chat-search-field'),
            controller: _searchController,
            placeholder: '搜索',
            style: const TextStyle(
              color: textColor,
              fontSize: 17,
              letterSpacing: -0.4,
            ),
            placeholderStyle: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 17,
              letterSpacing: -0.4,
            ),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Color(0xFF8E8E93),
              size: 18,
            ),
            suffixMode: OverlayVisibilityMode.editing,
            backgroundColor: const Color(0xFFE9E9EB),
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsetsDirectional.fromSTEB(6, 8, 6, 8),
            onChanged: (_) => setState(() {}),
          ),
        ),
        const SizedBox(height: 12),
        const _ContactAccessCard(),
        const SizedBox(height: 12),
        SizedBox(
          height: 32,
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
              return _IosFilterChip(
                key: Key('filter-$filter'),
                label: filter,
                selected: _selectedFilter == filter,
                onTap: () => setState(() => _selectedFilter = filter),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        if (chats.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 34),
            child: Text(
              '没有找到会话',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          ...chats.map((chat) => ParticipateTile(element: chat)),
        const _LimitedContactsNotice(),
      ],
    );
  }
}

/// Cupertino filter chip matching Chinese WhatsApp iOS.
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFD8F5E2) : const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF128C4E) : textColor,
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
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F7),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          CupertinoIcons.plus,
          color: Color(0xFF8E8E93),
          size: 18,
        ),
      ),
    );
  }
}

class _ContactAccessCard extends StatelessWidget {
  const _ContactAccessCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFB7E8C5), width: 1),
      ),
      child: Column(
        children: [
          const Text(
            '允许完整联系人访问权限',
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '除非你允许完整访问权限，否则无法查找到你的所有亲朋好友。',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: iosSecondaryLabel,
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: const Color(0xFF25D366),
              borderRadius: BorderRadius.circular(18),
              onPressed: () {},
              child: const Text(
                '允许访问',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
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

class _LimitedContactsNotice extends StatelessWidget {
  const _LimitedContactsNotice();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
      child: Column(
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'WhatsApp 没有完整的联系人访问权限，因此部分姓名可能不会显示。',
              style: const TextStyle(
                color: iosSecondaryLabel,
                fontSize: 12,
                height: 1.45,
              ),
              children: [
                const TextSpan(text: ' '),
                TextSpan(
                  text: '允许访问权限',
                  style: TextStyle(
                    color: primaryColor.withOpacity(0.95),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_rounded, size: 11, color: iosSecondaryLabel),
              const SizedBox(width: 4),
              Text.rich(
                TextSpan(
                  text: '你的私人消息已进行',
                  style: const TextStyle(
                    color: iosSecondaryLabel,
                    fontSize: 11,
                  ),
                  children: [
                    TextSpan(
                      text: '端到端加密',
                      style: TextStyle(
                        color: primaryColor.withOpacity(0.95),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
