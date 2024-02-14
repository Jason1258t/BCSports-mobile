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
    final size = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: setUserAndOpenChat,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.black_s2new_1A1A1A,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            buildUserAvatar(),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<List<Message>>(
                      stream: FirebaseChatCore.instance.messages(widget.room),
                      builder: (context, snapshot) {
                        return Text(
                          getLastMessage(snapshot.data ?? []),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppFonts.font16w400
                              .copyWith(color: AppColors.white),
                        );
                      }),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    getOtherUserName() ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppFonts.font14w400
                        .copyWith(color: AppColors.grey_949BA5),
                  ),
                ],
              ),
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
              ? DecorationImage(
                  image: NetworkImage(user.avatarUrl!), fit: BoxFit.cover)
              : null),
      width: 64,
      height: 64,
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
