import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/assets.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class ChatMessagesScreen extends StatefulWidget {
  const ChatMessagesScreen({super.key, required this.room});

  final Room room;

  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  final chatCore = FirebaseChatCore.instance;

  final ChatTheme them = DarkChatTheme(
      secondaryColor: AppColors.primary,
      primaryColor: AppColors.black_s2new_1A1A1A,
      backgroundColor: Colors.black,
      inputBorderRadius: BorderRadius.zero,
      receivedMessageBodyTextStyle:
          AppFonts.font14w400.copyWith(color: AppColors.black_s2new_1A1A1A),
      sentMessageBodyTextStyle:
          AppFonts.font14w400.copyWith(color: AppColors.white));

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.read<ChatRepository>().activeUser!;

    final userChatUser = context.read<ProfileRepository>().user.toChatUser();
    final sizeOf = MediaQuery.sizeOf(context);

    final repositoryProfilePreView =
        RepositoryProvider.of<ProfileViewRepository>(context);
    final repositoryChatRepository =
        RepositoryProvider.of<ChatRepository>(context);

    final localize = AppLocalizations.of(context)!;

    void sendMessage(){
      if(messageController.text != ''){
        repositoryChatRepository.sendMessage(
            widget.room.id, PartialText(text: messageController.text));

        messageController.setText('');
      }
    }

    return CustomScaffold(
      resize: true,
      padding: EdgeInsets.zero,
      appBar: EmptyAppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: InkWell(
            onTap: () {
              repositoryProfilePreView.setUser(user.id);
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
                      customBottomWidget: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                        color: AppColors.black_252525,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.black_s2new_1A1A1A,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width *
                                    290 /
                                    375,
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  minLines: 1,
                                  maxLines: 4,
                                  controller: messageController,
                                  style: AppFonts.font14w400,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintStyle: AppFonts.font14w400,
                                      hintText: localize.message,
                                      border: InputBorder.none),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    sendMessage();
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    padding: const EdgeInsets.all(6),
                                    child: SvgPicture.asset(Assets.icons(
                                        'send_message_messenger.svg')),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                });
          }),
    );
  }

  void send(types.PartialText message) {
    context.read<ChatRepository>().sendMessage(widget.room.id, message);
  }
}
