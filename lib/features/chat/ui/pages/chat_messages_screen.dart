import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen({super.key});

  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  List<types.Message> _messages = [];
  final _user = types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  Widget build(BuildContext context) {
    return Chat(
        messages: _messages, onSendPressed: _handleFileSelection, user: _user);
  }

  void _handleFileSelection(types.PartialText message) async {
    final textMassage = types.TextMessage(
      text: message.text,
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'id',
    );

    _addMessage(textMassage);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }
}
