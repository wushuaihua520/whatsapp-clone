import 'package:whatsapp_ios_ui/data/model/channel_news_model.dart';
import 'package:whatsapp_ios_ui/utils/k_images.dart';

import 'model/call_log_model.dart';
import 'model/chats_model.dart';
import 'model/participants_chat_model.dart';

class KDummyData {
  static List<Participant> chatsList = [
    Participant(
        id: 1,
        avatar: KImages.chatAvatar1,
        name: "Martin Troff",
        lastMessage: "See you at 7:30 👋",
        messageFrom: "user",
        isImage: false,
        seen: true,
        delivered: true,
        unread: 0,
        sent: true,
        date: DateTime.now().subtract(const Duration(minutes: 4)).toString()),
    Participant(
        id: 2,
        avatar: KImages.chatAvatar2,
        name: "Weekend Crew",
        lastMessage: "Aisha: The photos are ready!",
        messageFrom: "sender",
        isImage: false,
        seen: true,
        delivered: true,
        sent: true,
        unread: 6,
        date: DateTime.now().subtract(const Duration(minutes: 18)).toString()),
    Participant(
        id: 3,
        avatar: KImages.chatAvatar3,
        name: "Carla Korsgaard",
        lastMessage: "Voice message",
        messageFrom: "sender",
        seen: true,
        delivered: true,
        sent: true,
        unread: 0,
        date: DateTime.now().subtract(const Duration(hours: 1)).toString(),
        isImage: false),
    Participant(
        id: 4,
        avatar: KImages.chatAvatar4,
        name: "Zaire Passaquindici",
        lastMessage: "That sounds perfect, thank you",
        messageFrom: "sender",
        seen: true,
        delivered: true,
        sent: true,
        unread: 2,
        date: DateTime.now().subtract(const Duration(hours: 3)).toString(),
        isImage: false),
    Participant(
        id: 5,
        avatar: KImages.chatAvatar5,
        name: "Terry Dokidis",
        lastMessage: "Are you available for a quick call?",
        messageFrom: "user",
        seen: false,
        delivered: true,
        sent: true,
        unread: 0,
        date: DateTime.now().subtract(const Duration(days: 1)).toString(),
        isImage: false),
    Participant(
        id: 6,
        avatar: KImages.chatAvatar6,
        name: "Design Team",
        lastMessage: "Philip: Shared a document",
        messageFrom: "sender",
        seen: true,
        delivered: true,
        sent: true,
        unread: 0,
        date: DateTime.now().subtract(const Duration(days: 2)).toString(),
        isImage: false),
    Participant(
        id: 7,
        avatar: KImages.chatAvatar7,
        name: "Alfanso Rhifel",
        lastMessage: "The new build looks great",
        messageFrom: "sender",
        seen: true,
        delivered: true,
        sent: true,
        unread: 0,
        date: DateTime.now().subtract(const Duration(days: 4)).toString(),
        isImage: false),
  ];

  static List<Map<String, String>> storyList = [
    {
      "user": "Martin Luther",
      "avatar": KImages.chatAvatar1,
    },
    {
      "user": "Carla Korsgaard",
      "avatar": KImages.chatAvatar3,
    },
    {
      "user": "Philip Westervelt",
      "avatar": KImages.chatAvatar6,
    }
  ];

  static ParticipantsChat participantsChat = ParticipantsChat(
      id: 1,
      participant: "Martin Troff",
      avatar: KImages.chatAvatar1,
      status: "online",
      contact: "01712312312",
      messages: <Messages>[
        Messages(
          id: 1,
          message: "Hi",
          sender: "participant",
          date: DateTime.now(),
          seen: true,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 2,
          message: "Hello",
          sender: "user",
          date: DateTime.now(),
          seen: true,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 3,
          message: "How are you?",
          sender: "user",
          date: DateTime.now(),
          seen: true,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 4,
          message: "I'm absolutely fine, what about you?",
          sender: "participant",
          date: DateTime.now(),
          seen: true,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 5,
          message: "Everything is going well",
          sender: "user",
          date: DateTime.now(),
          seen: true,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 6,
          message: "Have you done your assignments?",
          sender: "participant",
          date: DateTime.now(),
          seen: true,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 7,
          message: "No! not yet",
          sender: "user",
          date: DateTime.now(),
          seen: true,
          delivered: true,
          sent: true,
        ),
      ]);

  static List<ChannelNews> channelNews = [
    ChannelNews(
      channelName: "The New York Times",
      avatar: KImages.newYorkTimes,
      news: "Morning briefing: five stories to start your day.",
      isImageAttached: true,
      newImage: KImages.chatAvatar4,
      date: DateTime.now().subtract(const Duration(minutes: 12)).toString(),
      unread: "3",
    ),
    ChannelNews(
      channelName: "Al Jazeera",
      avatar: KImages.alJazeera,
      news: "Watch the latest stories from around the world.",
      isImageAttached: true,
      newImage: KImages.chatAvatar3,
      date: DateTime.now().subtract(const Duration(hours: 1)).toString(),
      unread: "1",
    ),
    ChannelNews(
      channelName: "Mark Zuckerberg",
      avatar: KImages.markZuck,
      news: "Building new ways for people to connect.",
      isImageAttached: true,
      newImage: KImages.chatAvatar2,
      date: DateTime.now().subtract(const Duration(hours: 3)).toString(),
    ),
    ChannelNews(
      channelName: "BBC News",
      avatar: KImages.bbc,
      news: "The latest technology, science and culture headlines.",
      isImageAttached: true,
      newImage: KImages.chatAvatar6,
      date: DateTime.now().subtract(const Duration(days: 1)).toString(),
    ),
  ];

  static List<CallLog> callHistory = [
    CallLog(
      personName: "Martin Loe",
      avatar: KImages.chatAvatar1,
      time: "Today, 11:30 AM",
      callType: "Video",
      isMissed: false,
      incoming: false,
      numberOfCall: 2,
    ),
    CallLog(
        personName: "Carla Korsgaard",
        avatar: KImages.chatAvatar3,
        time: "Yesterday, 8:47 PM",
        callType: "video",
        isMissed: true,
        incoming: true,
        numberOfCall: 2),
    CallLog(
        personName: "John Doe",
        avatar: KImages.chatAvatar5,
        time: "Yesterday, 8:47 PM",
        callType: "audio",
        isMissed: false,
        incoming: true,
        numberOfCall: 2),
  ];

  static List<Map<String, String>> contacts = [
    {"user": "Martin Luther", "avatar": KImages.chatAvatar1, "status": "Busy"},
    {
      "user": "Bill Gates",
      "avatar": KImages.chatAvatar2,
      "status": "At school"
    },
    {
      "user": "Elon Musk",
      "avatar": KImages.chatAvatar3,
      "status": "Call me later"
    },
    {
      "user": "Tom Cruise",
      "avatar": KImages.chatAvatar4,
      "status": "I'm in a meeting"
    },
    {
      "user": "Barack Obama",
      "avatar": KImages.chatAvatar5,
      "status": "Available"
    },
    {"user": "Brandan M", "avatar": KImages.chatAvatar6, "status": "At gym"},
  ];
}
