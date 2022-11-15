import 'package:flutter/material.dart';

class Message {
  final String message;
  final num type;

  static Message NoMessage = Message("");
  static const int RED = 3;
  static const int GREEN = 2;
  static const int WHITE = 1;

  // Messages Type

  Message(this.message, {this.type = WHITE});
}

class StatusMessages with ChangeNotifier {
  Message currentMessage = Message("First Message");

  void changeMessage(Message? message) {
    if (message != null) {
      if (message.type > currentMessage.type) currentMessage = message;
    }
    notifyListeners();
  }

  String displayMessage() {
    String mess = currentMessage.message;
    currentMessage = Message.NoMessage;
    return mess;
  }
}
