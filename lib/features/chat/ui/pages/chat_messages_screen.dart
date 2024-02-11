import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/widgets/appBar/empty_app_bar.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen({super.key, required this.room});

  final Room room;

  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  final chatCore = FirebaseChatCore.instance;

  final ChatTheme them = const DarkChatTheme();

  @override
  Widget build(BuildContext context) {
    final user = context.read<ProfileRepository>().user.toChatUser();

    return CustomScaffold(
      padding: EdgeInsets.zero,
      appBar: EmptyAppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonBack(
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: chatCore.room(widget.room.id),
          initialData: widget.room,
          builder: (context, snapshot) {
            return StreamBuilder<List<types.Message>>(
                stream: chatCore.messages(snapshot.data ?? widget.room),
                initialData: widget.room.lastMessages ?? [],
                builder: (context, snapshot) {
                  return Chat(
                      messages: snapshot.data ?? [],
                      onSendPressed: send,
                      user: user,
                      theme: them);
                });
          }),
    );
  }

  void send(types.PartialText message) {
    context.read<ChatRepository>().sendMessage(widget.room.id, message);
  }
}
