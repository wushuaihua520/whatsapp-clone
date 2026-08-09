import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../data/dummy_data.dart';
import '../../../data/model/chats_model.dart';
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
  String _selectedFilter = 'All';

  static const _filters = ['All', 'Unread', 'Favorites', 'Groups'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Participant> get _visibleChats {
    Iterable<Participant> chats = KDummyData.chatsList;

    switch (_selectedFilter) {
      case 'Unread':
        chats = chats.where((chat) => chat.unread > 0);
        break;
      case 'Favorites':
        chats = chats.where((chat) => const [1, 3, 5].contains(chat.id));
        break;
      case 'Groups':
        chats = chats.where((chat) => const [2, 6].contains(chat.id));
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
      padding: const EdgeInsets.only(bottom: 104),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
          child: TextField(
            key: const Key('chat-search-field'),
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Ask Meta AI or Search',
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: subTitleTextColor,
              ),
              suffixIcon: _searchController.text.isEmpty
                  ? const Icon(
                      Icons.auto_awesome_rounded,
                      size: 20,
                      color: Color(0xFF635BFF),
                    )
                  : IconButton(
                      tooltip: 'Clear',
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
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
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
                      ? selectedNavColor
                      : borderColor,
                ),
                shape: const StadiumBorder(),
                labelStyle: TextStyle(
                  color: _selectedFilter == filter
                      ? primaryColor
                      : subTitleTextColor,
                  fontWeight: FontWeight.w500,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 3),
                onSelected: (_) => setState(() => _selectedFilter = filter),
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        const ArchiveTile(),
        if (chats.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 56),
            child: Column(
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 42,
                  color: subTitleTextColor,
                ),
                SizedBox(height: 14),
                Text(
                  'No chats found',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Try a different search or filter.',
                  style: TextStyle(color: subTitleTextColor),
                ),
              ],
            ),
          )
        else
          ...chats.map((chat) => ParticipateTile(element: chat)),
      ],
    );
  }
}

class ArchiveTile extends StatelessWidget {
  const ArchiveTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      minLeadingWidth: 56,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: SizedBox(
        width: 56,
        child: Icon(
          Icons.archive_outlined,
          color: primaryColor,
          size: 24,
        ),
      ),
      title: Text(
        'Archived',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      trailing: Text(
        '5',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }
}
