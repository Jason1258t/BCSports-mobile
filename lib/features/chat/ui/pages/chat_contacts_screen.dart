import 'package:bcsports_mobile/features/chat/bloc/user_search_cubit.dart';
import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/chat/ui/pages/chat_messages_screen.dart';
import 'package:bcsports_mobile/features/chat/ui/widgets/small_user_card.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';

class ChatContactsScreen extends StatefulWidget {
  const ChatContactsScreen({super.key});

  @override
  State<ChatContactsScreen> createState() => _ChatContactsScreenState();
}

class _ChatContactsScreenState extends State<ChatContactsScreen> {
  final TextEditingController searchController = TextEditingController();

  final String title = "Contacts";

  bool isOpenSearch = false;

  @override
  Widget build(BuildContext context) {
    final ChatRepository chatRepository = context.read<ChatRepository>();

    final sizeOf = MediaQuery.sizeOf(context);

    return CustomScaffold(
      onTap: () {
        setState(() {
          isOpenSearch = false;
        });
      },
      appBar: AppBar(
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonBack(
                onTap: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Text(
                title,
                style: AppFonts.font18w500.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      color: AppColors.background,
      body: Column(
        children: [
          CustomTextFormField(
              onChange: (v) {
                context
                    .read<UserSearchCubit>()
                    .searchByString(v == '' ? '123412dfasdaf' : v!);
                setState(() {
                  isOpenSearch = MediaQuery.of(context).viewInsets.bottom != 0;
                });
              },
              onTap: () {
                context.read<UserSearchCubit>().searchByString(
                    searchController.text == ''
                        ? '123123123'
                        : searchController.text);

                setState(() {
                  isOpenSearch = true;
                });
              },
              prefixIcon: const Icon(Icons.search),
              controller: searchController),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                    child: StreamBuilder<List<Room>>(
                        stream: chatRepository.roomsStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              if (snapshot.hasData) ...generateChats(snapshot)
                            ],
                          );
                        })),
              ),
              Container(
                color: AppColors.black,
                child: AnimatedContainer(
                  margin: const EdgeInsets.only(top: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  duration: const Duration(milliseconds: 100),
                  width: double.infinity,
                  height: isOpenSearch ? sizeOf.height * 0.5 : 0,
                  decoration: BoxDecoration(
                      color: AppColors.black_s2new_1A1A1A,
                      borderRadius: BorderRadius.circular(10)),
                  child: BlocBuilder<UserSearchCubit, UserSearchState>(
                    builder: (context, state) {
                      if (state is UserSearchSuccessState &&
                          chatRepository.filteredUserList.isNotEmpty) {
                        return Column(children: generateFoundUsers());
                      } else if (state is UserSearchSuccessState &&
                          chatRepository.filteredUserList.isEmpty) {
                        return const Text('Тo result');
                      } else {
                        return Center(
                          child: AppAnimations.circleIndicator,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> generateChats(AsyncSnapshot<List<Room>> snapshot) {
    return snapshot.data!
        .map((e) => ChatCardPreviewWidget(
              room: e,
            ))
        .toList();
  }

  List<Widget> generateFoundUsers() {
    final chatRepository = context.read<ChatRepository>();
    final currentUserId = context.read<ProfileRepository>().user.id;

    return chatRepository.filteredUserList
        .map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SmallUserCard(
                onTap: () async {
                  if (e.id != currentUserId) {
                    Room? room = await chatRepository.roomWithUserExists(e.id);
                    room ??= await chatRepository.createRoomWithUser(e);

                    chatRepository.setActiveUser(e);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatMessagesScreen(room: room!)));
                  }
                },
                userModel: e,
              ),
            ))
        .toList();
  }
}

class ChatCardPreviewWidget extends StatelessWidget {
  const ChatCardPreviewWidget({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileRepository>();
    final chatRepository = context.read<ChatRepository>();

    Widget getUserAvatar() {
      for (var i in room.users) {
        if (i.id != profile.user.id) {
          final user = chatRepository.getUserById(i.id)!;

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
      }
      return Container();
    }

    String? getOtherUserName() {
      final profile = context.read<ProfileRepository>();
      final chat = context.read<ChatRepository>();
      for (var i in room.users) {
        if (i.id != profile.user.id) {
          final user = chat.getUserById(i.id)!;
          return user.displayName ?? user.username;
        }
      }
      return null;
    }

    String getLastMessage() {
      final messages = room.lastMessages ?? [];

      if (messages.isNotEmpty) {
        final lastMessage = messages.last;

        if (lastMessage.type == MessageType.text) {
          return (lastMessage as TextMessage).text;
        }

        return 'attachment';
      }

      return '';
    }

    final charRepository = RepositoryProvider.of<ChatRepository>(context);

    return InkWell(
      onTap: () {
        for (var i in room.users) {
          if (i.id != profile.user.id) {
            charRepository.setActiveUser(chatRepository.getUserById(i.id)!);
          }
        }

        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ChatMessagesScreen(room: room)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            getUserAvatar(),
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
                Text(
                  getLastMessage(),
                  style: AppFonts.font12w400.copyWith(color: AppColors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
