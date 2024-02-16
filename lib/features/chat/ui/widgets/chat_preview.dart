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

import '../../../../utils/time_difference.dart';

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

    print(size.width);

    return InkWell(
      onTap: setUserAndOpenChat,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.only(left: 10, top: 10 , bottom: 10, right: 0),
        child: Row(
          children: [
            buildUserAvatar(),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              width: (size.width - 106) * 0.843,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getOtherUserName() ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppFonts.font16w400.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  StreamBuilder<List<Message>>(
                      stream: FirebaseChatCore.instance.messages(widget.room),
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (size.width - 106) * 0.51,
                              child: Text(
                                getLastMessage(snapshot.data ?? []),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppFonts.font14w400
                                    .copyWith(color: AppColors.grey_949BA5),
                              ),
                            ),
                            SizedBox(
                              width: (size.width - 106) * 0.333,
                              child: Text(
                                getLastMessageTime(snapshot.data ?? []) != null
                                    ? DateTimeDifferenceConverter.diffToString(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                getLastMessageTime(
                                                    snapshot.data ?? [])!))
                                        .toString()
                                    : '',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                style: AppFonts.font12w300
                                    .copyWith(color: AppColors.grey_949BA5),
                              ),
                            ),
                          ],
                        );
                      }),
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

    final sizeOf = MediaQuery.sizeOf(context);

    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: user.avatarColor,
          image: user.avatarUrl != null
              ? DecorationImage(
                  image: NetworkImage(user.avatarUrl!), fit: BoxFit.cover)
              : null),
      width: (sizeOf.width -106) * 0.157,
      height:  (sizeOf.width -106) * 0.157,
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
      final lastMessage = messages.first;

      if (lastMessage.type == MessageType.text) {
        return (lastMessage as TextMessage).text;
      }

      return 'attachment';
    }

    return '';
  }

  int? getLastMessageTime(List<Message> messages) {
    if (messages.isNotEmpty) {
      final lastMessage = messages.first;

      return (lastMessage as TextMessage).createdAt;
    }

    return null;
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
