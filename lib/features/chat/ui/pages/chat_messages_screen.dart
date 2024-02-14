import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/appBar/empty_app_bar.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:intl/intl.dart';

class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen({super.key, required this.room});

  final Room room;

  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  final chatCore = FirebaseChatCore.instance;

  final ChatTheme them = const DarkChatTheme(
      backgroundColor: Colors.black, inputBorderRadius: BorderRadius.zero, );

  @override
  Widget build(BuildContext context) {
    final user = context.read<ChatRepository>().activeUser!;

    final userChatUser = context.read<ProfileRepository>().user.toChatUser();
    final sizeOf = MediaQuery.sizeOf(context);

    final repository = RepositoryProvider.of<ProfileViewRepository>(context);

    return CustomScaffold(
      padding: EdgeInsets.zero,
      appBar: EmptyAppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: InkWell(
            onTap: () {
              repository.setUser(user.id);
              Navigator.pushNamed(context, AppRouteNames.profileView);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonBack(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  user.username,
                  style: AppFonts.font16w500,
                ),
                CircleAvatar(
                  backgroundColor: user.avatarColor,
                  radius: sizeOf.width * 0.05,
                  backgroundImage: user.avatarUrl == null
                      ? null
                      : NetworkImage(user.avatarUrl!),
                  child: user.avatarUrl == null
                      ? Center(
                          child: Text(
                            (user.displayName ?? user.username)[0]
                                .toUpperCase(),
                            style: AppFonts.font12w400,
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
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
                    user: userChatUser,
                    theme: them,
                  );
                });
          }),
    );
  }

  void send(types.PartialText message) {
    context.read<ChatRepository>().sendMessage(widget.room.id, message);
  }
}
