import 'package:flutter/material.dart';
import 'package:whatsapp_clone/data/model/channel_news_model.dart';
import 'package:whatsapp_clone/utils/k_images.dart';

import 'model/call_log_model.dart';
import 'model/chats_model.dart';
import 'model/participants_chat_model.dart';

class KDummyData {
  static List<Participant> chatsList = [
    Participant(
      id: 1,
      avatar: KImages.logo,
      name: "WhatsApp",
      lastMessage: "编辑已发送的消息 发消息时不小心打错了字？这没什么，不用担心，无论是表...",
      messageFrom: "sender",
      isImage: false,
      seen: true,
      delivered: true,
      unread: 0,
      sent: true,
      date: DateTime(2024, 1, 28).toString(),
      dateLabel: "2024/1/28",
      isVideoPreview: true,
    ),
    Participant(
      id: 2,
      avatar: '',
      name: "+852 5923 9971",
      lastMessage: "你挂断了线",
      messageFrom: "user",
      isImage: false,
      seen: true,
      delivered: true,
      sent: true,
      unread: 0,
      date: DateTime(2024, 1, 21).toString(),
      dateLabel: "2024/1/21",
      usePlaceholderAvatar: true,
      placeholderColor: const Color(0xFFF5B27A),
    ),
    Participant(
      id: 3,
      avatar: KImages.chatAvatar3,
      name: "Carla Korsgaard",
      lastMessage: "How are you today?",
      messageFrom: "sender",
      seen: true,
      delivered: true,
      sent: true,
      unread: 0,
      date: DateTime.now().toString(),
      dateLabel: "昨天",
      isImage: false,
    ),
    Participant(
      id: 4,
      avatar: KImages.chatAvatar4,
      name: "Zaire Passaquindici",
      lastMessage: "Sorry, I couldn't attend your party",
      messageFrom: "sender",
      seen: true,
      delivered: true,
      sent: true,
      unread: 3,
      date: DateTime.now().toString(),
      dateLabel: "周一",
      isImage: false,
    ),
    Participant(
      id: 5,
      avatar: KImages.chatAvatar5,
      name: "Terry Dokidis",
      lastMessage: "Hey! are you available?",
      messageFrom: "user",
      seen: false,
      delivered: false,
      sent: true,
      unread: 0,
      date: DateTime.now().toString(),
      dateLabel: "周日",
      isImage: false,
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
    avatar: '',
    status: "在线",
    contact: "+852 5923 9971",
    usePlaceholder: true,
    messages: <Messages>[
      Messages(
        id: 1,
        message: "hi",
        sender: "user",
        date: DateTime(2024, 1, 14, 22, 49),
        seen: true,
        delivered: true,
        sent: true,
      ),
      Messages(
        id: 2,
        message: "就叫著曼琳",
        sender: "participant",
        date: DateTime(2024, 1, 14, 22, 50),
        seen: true,
        delivered: true,
        sent: true,
      ),
      Messages(
        id: 3,
        message: "怎么称呼你",
        sender: "participant",
        date: DateTime(2024, 1, 14, 22, 50),
        seen: true,
        delivered: true,
        sent: true,
      ),
      Messages(
        id: 4,
        message: "",
        sender: "participant",
        date: DateTime(2024, 1, 14, 22, 50),
        seen: true,
        delivered: true,
        sent: true,
        image: KImages.chatAvatar2,
      ),
      Messages(
        id: 5,
        message: "这是我本人",
        sender: "participant",
        date: DateTime(2024, 1, 14, 23, 0),
        seen: true,
        delivered: true,
        sent: true,
      ),
      Messages(
        id: 6,
        message: "很高兴认识你！！",
        sender: "user",
        date: DateTime(2026, 1, 19, 18, 50),
        seen: true,
        delivered: true,
        sent: true,
      ),
      Messages(
        id: 7,
        message: "☕😊",
        sender: "participant",
        date: DateTime(2026, 1, 19, 18, 56),
        seen: true,
        delivered: true,
        sent: true,
        isSticker: true,
      ),
      Messages(
        id: 8,
        message: "你好呀",
        sender: "user",
        date: DateTime(2026, 1, 19, 21, 27),
        seen: true,
        delivered: true,
        sent: true,
        replyTo: "就叫著曼琳",
        replyAuthor: "+852 5923 9971",
      ),
    ],
  );

  static List<ChannelNews> channelNews = [
    ChannelNews(
      channelName: "The New York Times",
      avatar: KImages.newYorkTimes,
      news:
          "An Israeli airstrike hit a Gaza hospital on Tuesday, killing at least 200 Palestinians, according to the Palestinian Health Minister.",
      isImageAttached: true,
      newImage: "assets/images/morskie-oko-tatry.jpg",
      date: DateTime.now().toString(),
    ),
    ChannelNews(
      channelName: "Al Jazeera",
      avatar: KImages.alJazeera,
      news:
          "An Israeli airstrike hit a Gaza hospital on Tuesday, killing at least 200 Palestinians, according to the Palestinian Health Minister.",
      isImageAttached: true,
      newImage: "assets/images/morskie-oko-tatry.jpg",
      date: DateTime.now().toString(),
    ),
    ChannelNews(
      channelName: "Mark Zuckerberg",
      avatar: KImages.markZuck,
      news:
          "An Israeli airstrike hit a Gaza hospital on Tuesday, killing at least 200 Palestinians, according to the Palestinian Health Minister.",
      isImageAttached: true,
      newImage: "assets/images/morskie-oko-tatry.jpg",
      date: DateTime.now().toString(),
    ),
    ChannelNews(
      channelName: "BBC News",
      avatar: KImages.bbc,
      news:
          "An Israeli airstrike hit a Gaza hospital on Tuesday, killing at least 200 Palestinians, according to the Palestinian Health Minister.",
      isImageAttached: true,
      newImage: "assets/images/morskie-oko-tatry.jpg",
      date: DateTime.now().toString(),
    ),
  ];

  static List<CallLog> callHistory = [
    CallLog(
      personName: "Martin Loe",
      avatar: KImages.chatAvatar1,
      time: "今天, 11:30 AM",
      callType: "Video",
      isMissed: false,
      incoming: false,
      numberOfCall: 2,
    ),
    CallLog(
      personName: "Carla Korsgaard",
      avatar: KImages.chatAvatar1,
      time: "昨天, 8:47 PM",
      callType: "video",
      isMissed: true,
      incoming: true,
      numberOfCall: 2,
    ),
    CallLog(
      personName: "John Doe",
      avatar: KImages.chatAvatar1,
      time: "昨天, 8:47 PM",
      callType: "audio",
      isMissed: false,
      incoming: true,
      numberOfCall: 2,
    ),
  ];

  static List<Map<String, String>> contacts = [
    {"user": "Martin Luther", "avatar": KImages.chatAvatar1, "status": "Busy"},
    {
      "user": "Bill Gates",
      "avatar": KImages.chatAvatar2,
      "status": "At school"
    },
    {
      "user": "Elon Mask",
      "avatar": KImages.chatAvatar3,
      "status": "Call me later"
    },
    {
      "user": "Tom Cruise",
      "avatar": KImages.chatAvatar4,
      "status": "I'm in a meeting"
    },
    {
      "user": "Barak Obama",
      "avatar": KImages.chatAvatar5,
      "status": "Available"
    },
    {"user": "Brandan M", "avatar": KImages.chatAvatar6, "status": "At gym"},
  ];
}
