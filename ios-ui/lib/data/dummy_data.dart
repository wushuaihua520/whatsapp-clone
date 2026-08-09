import 'package:whatsapp_ios_ui/data/model/channel_news_model.dart';
import 'package:whatsapp_ios_ui/utils/k_images.dart';

import 'model/call_log_model.dart';
import 'model/chats_model.dart';
import 'model/participants_chat_model.dart';

class KDummyData {
  static List<Participant> chatsList = [
    Participant(
      id: 1,
      avatar: KImages.logo,
      name: "WhatsApp",
      lastMessage: "📷 视频已发送的消息：发消息时不小心打错了字？还没什么，不用担心，...",
      messageFrom: "sender",
      isImage: false,
      seen: true,
      delivered: true,
      unread: 0,
      sent: true,
      date: DateTime(2024, 1, 29, 9, 28).toString(),
    ),
    Participant(
      id: 2,
      avatar: KImages.chatAvatar2,
      name: "+852 5923 9971",
      lastMessage: "后回了句",
      messageFrom: "sender",
      isImage: false,
      seen: true,
      delivered: true,
      sent: true,
      unread: 1,
      date: DateTime(2024, 1, 21, 20, 18).toString(),
    ),
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
      participant: "+852 5923 9971",
      avatar: KImages.chatAvatar2,
      status: "",
      contact: "+852 5923 9971",
      messages: <Messages>[
        Messages(
          id: 1,
          message: "hi",
          sender: "user",
          date: DateTime(2024, 1, 14, 22, 49),
          seen: false,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 2,
          message: "我叫袁爱萍",
          sender: "participant",
          date: DateTime(2024, 1, 14, 23, 50),
          seen: true,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 3,
          message: "怎么称呼你",
          sender: "participant",
          date: DateTime(2024, 1, 14, 23, 50),
          seen: true,
          delivered: true,
          sent: true,
        ),
        Messages(
          id: 4,
          message: "",
          sender: "participant",
          date: DateTime(2024, 1, 14, 23, 50),
          seen: true,
          delivered: true,
          sent: true,
          image: KImages.chatPhoto,
        ),
        Messages(
          id: 5,
          message: "这是我本人",
          sender: "participant",
          date: DateTime(2024, 1, 14, 23, 50),
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
