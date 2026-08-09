import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../data/dummy_data.dart';
import '../../../data/model/chats_model.dart';
import '../../../utils/constants.dart';
import '../../core/routes/routes_name.dart';

/// Chats tab — Cupertino large title + search + inset list.
class ConversationList extends StatefulWidget {
  const ConversationList({super.key});

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

    return CupertinoPageScaffold(
      backgroundColor: scaffoldBgColor,
      child: CustomScrollView(
        key: const PageStorageKey('conversation-list'),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('聊天', key: Key('ios-聊天-title')),
            backgroundColor: const Color(0xF7F9F9F9),
            border: null,
            transitionBetweenRoutes: false,
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              onPressed: () {},
              child: Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5E5EA),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.ellipsis,
                  size: 18,
                  color: textColor,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.only(right: 8),
                  minSize: 0,
                  onPressed: () {},
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5E5EA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.camera,
                      size: 18,
                      color: textColor,
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RouteNames.contactPage),
                  child: Container(
                    key: const Key('ios-new-chat'),
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFF25D366),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.plus,
                      color: CupertinoColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 4)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: CupertinoSearchTextField(
                key: const Key('chat-search-field'),
                controller: _searchController,
                placeholder: '搜索',
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: _ContactAccessCard()),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                itemCount: _filters.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == _filters.length) {
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      onPressed: () {},
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5.resolveFrom(context),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.plus,
                          size: 18,
                          color: textColor,
                        ),
                      ),
                    );
                  }
                  final filter = _filters[index];
                  final selected = _selectedFilter == filter;
                  return CupertinoButton(
                    key: Key('filter-$filter'),
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: () =>
                        setState(() => _selectedFilter = filter),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFF25D366)
                            : const Color(0x00000000),
                        borderRadius: BorderRadius.circular(16),
                        border: selected
                            ? null
                            : Border.all(
                                color: const Color(0xFFC7C7CC),
                                width: 1,
                              ),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: selected
                              ? CupertinoColors.white
                              : textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (chats.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('没有找到会话')),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == chats.length) {
                    return const _LimitedContactsNotice();
                  }
                  return _ChatRow(chat: chats[index]);
                },
                childCount: chats.length + 1,
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
    );
  }
}

class _ChatRow extends StatelessWidget {
  const _ChatRow({required this.chat});

  final Participant chat;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(chat.date);
    final timeLabel =
        date == null ? '' : DateFormat('yyyy/M/d').format(date);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => Navigator.of(context).pushNamed(RouteNames.inbox),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0x143C3C43), width: 0.33),
          ),
        ),
        child: Row(
          children: [
            _Avatar(chat: chat),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      Text(
                        timeLabel,
                        style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    chat.lastMessage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 14.5,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.chat});

  final Participant chat;

  @override
  Widget build(BuildContext context) {
    if (chat.id == 1) {
      return SizedBox(
        width: 52,
        height: 52,
        child: Image.asset(chat.avatar, fit: BoxFit.contain),
      );
    }
    return Container(
      width: 52,
      height: 52,
      decoration: const BoxDecoration(
        color: Color(0xFFF4E7C9),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        CupertinoIcons.person_fill,
        color: Color(0xFFB78032),
        size: 28,
      ),
    );
  }
}

class _ContactAccessCard extends StatelessWidget {
  const _ContactAccessCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFB7E8C5)),
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
              color: CupertinoColors.systemGrey,
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
                  color: CupertinoColors.white,
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
    return const Padding(
      padding: EdgeInsets.fromLTRB(28, 20, 28, 40),
      child: Column(
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'WhatsApp 没有完整的联系人访问权限，因此部分姓名可能不会显示。 ',
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 12,
                height: 1.45,
              ),
              children: [
                TextSpan(
                  text: '允许访问权限',
                  style: TextStyle(color: primaryColor, fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.lock_fill,
                size: 11,
                color: CupertinoColors.systemGrey,
              ),
              SizedBox(width: 4),
              Text.rich(
                TextSpan(
                  text: '你的私人消息已进行',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 11,
                  ),
                  children: [
                    TextSpan(
                      text: '端到端加密',
                      style: TextStyle(color: primaryColor, fontSize: 11),
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
