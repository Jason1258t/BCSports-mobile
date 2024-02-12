import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/chat/ui/pages/chat_messages_screen.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class ChatCardPreviewWidget extends StatefulWidget {
  const ChatCardPreviewWidget({super.key, required this.room});

  final Room room;

  @override
  State<ChatCardPreviewWidget> createState() => _ChatCardPreviewWidgetState();
}

class _ChatCardPreviewWidgetState extends State<ChatCardPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: setUserAndOpenChat,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            buildUserAvatar(),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getOtherUserName() ?? '',
                  style: AppFonts.font14w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                StreamBuilder<List<Message>>(
                    stream: FirebaseChatCore.instance.messages(widget.room),
                    builder: (context, snapshot) {
                      return Text(
                        getLastMessage(snapshot.data ?? []),
                        style: AppFonts.font12w400
                            .copyWith(color: AppColors.white),
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }


  UserModel? getOtherUser() {
    final currentUserId = context.read<ProfileRepository>().user.id;
    final chatRepository = context.read<ChatRepository>();

    for (var i in widget.room.users) {
      if (i.id != currentUserId) {
        final user = chatRepository.getUserById(i.id)!;
        return user;
      }
    }
    return null;
  }

  String? getOtherUserName() {
    final user = getOtherUser()!;
    return user.displayName ?? user.username;
  }

  Widget buildUserAvatar() {
    final user = getOtherUser()!;

    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: user.avatarColor,
          image: user.avatarUrl != null
              ? DecorationImage(image: NetworkImage(user.avatarUrl!))
              : null),
      width: 48,
      height: 48,
      child: user.avatarUrl == null
          ? Center(
        child: Text(
          (user.displayName ?? user.username)[0].toUpperCase(),
          style: AppFonts.font16w400,
        ),
      )
          : Container(),
    );
  }

  String getLastMessage(List<Message> messages) {
    if (messages.isNotEmpty) {
      final lastMessage = messages.last;

      if (lastMessage.type == MessageType.text) {
        return (lastMessage as TextMessage).text;
      }

      return 'attachment';
    }

    return '';
  }

  void setUserAndOpenChat() {
    final chatRepository = context.read<ChatRepository>();
    final user = getOtherUser()!;
    chatRepository.setActiveUser(user);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChatMessagesScreen(room: widget.room)));
  }
}
