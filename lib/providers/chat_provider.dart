import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Message {
  final String sender;
  final String recipient;
  final String text;
  final DateTime timestamp;

  Message(
      {required this.sender,
      required this.recipient,
      required this.text,
      required this.timestamp});

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'recipient': recipient,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: json['sender'],
        recipient: json['recipient'],
        text: json['text'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

class ChatProvider extends ChangeNotifier {
  List<Message> _messages = [];

  ChatProvider() {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesJson = prefs.getString('messages');
    if (messagesJson != null) {
      final List<dynamic> decodedMessages = jsonDecode(messagesJson);
      _messages = decodedMessages.map((m) => Message.fromJson(m)).toList();
      notifyListeners();
    }
  }

  Future<void> deleteMessage(Message message) async {
    _messages.removeWhere((m) =>
        m.sender == message.sender &&
        m.recipient == message.recipient &&
        m.text == message.text &&
        m.timestamp == message.timestamp);
    await _saveMessages();
    notifyListeners();
  }

  Future<void> deleteAllMessagesWithUser(
      String currentUser, String otherUser) async {
    _messages.removeWhere((m) =>
        (m.sender == currentUser && m.recipient == otherUser) ||
        (m.sender == otherUser && m.recipient == currentUser));
    await _saveMessages();
    notifyListeners();
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String messagesJson =
        jsonEncode(_messages.map((m) => m.toJson()).toList());
    await prefs.setString('messages', messagesJson);
  }

  void addMessage(Message message) {
    _messages.add(message);
    _saveMessages();
    notifyListeners();
  }

  List<Message> getMessages(String currentUser, String otherUser) {
    return _messages
        .where((message) =>
            (message.sender == currentUser && message.recipient == otherUser) ||
            (message.sender == otherUser && message.recipient == currentUser))
        .toList();
  }

  List<String> getUniqueUsers(String currentUser) {
    Set<String> users = {};
    for (var message in _messages) {
      if (message.sender == currentUser) {
        users.add(message.recipient);
      } else if (message.recipient == currentUser) {
        users.add(message.sender);
      }
    }
    return users.toList();
  }
}
