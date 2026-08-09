import 'dart:async';

import 'package:whatsapp_clone/data/dummy_data.dart';

import '../../../../data/model/participants_chat_model.dart';

class MessageController {
  static final streamController = StreamController<List<Messages>>.broadcast();

  static StreamSink<List<Messages>> get streamSink => streamController.sink;

  static Stream<List<Messages>> get streamData => streamController.stream;
  static List<Messages> list = [];

  static init() {
    list = List<Messages>.from(KDummyData.participantsChat.messages);
    streamSink.add(list);
  }

  static addMessage(String message) {
    list = [
      Messages(
        id: DateTime.now().millisecondsSinceEpoch,
        message: message,
        sender: "user",
        date: DateTime.now(),
        seen: false,
        delivered: true,
        sent: true,
      ),
      ...list,
    ];
    streamSink.add(list);
  }

  dispose() {
    streamController.close();
  }
}
