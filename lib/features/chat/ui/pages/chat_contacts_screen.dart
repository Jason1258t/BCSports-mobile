import 'package:bcsports_mobile/features/chat/bloc/user_search_cubit.dart';
import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/chat/ui/pages/chat_messages_screen.dart';
import 'package:bcsports_mobile/features/chat/ui/widgets/chat_preview.dart';
import 'package:bcsports_mobile/features/chat/ui/widgets/small_user_card.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
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

  bool isOpenSearch = false;

  @override
  Widget build(BuildContext context) {
    final ProfileRepository profileRepository =
        context.read<ProfileRepository>();

    final ChatRepository chatRepository = context.read<ChatRepository>();

    final localize = AppLocalizations.of(context)!;

    return CustomScaffold(
      onTap: () {
        setState(() {
          isOpenSearch = false;
        });
      },
      appBar: AppBar(
        backgroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            localize.messages,
            style: AppFonts.font18w500.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
      color: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFormField(
                borderRadius: BorderRadius.circular(32),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onChange: (v) {
                  context.read<UserSearchCubit>().searchByString(
                      v == '' ? '123412dfasdaf' : v!,
                      profileRepository.user.id);
                  setState(() {
                    isOpenSearch =
                        MediaQuery.of(context).viewInsets.bottom != 0 ||
                            chatRepository.filteredUserList.isNotEmpty;
                  });
                },
                onTap: () {
                  context.read<UserSearchCubit>().searchByString(
                      searchController.text == ''
                          ? '123123123'
                          : searchController.text,
                      profileRepository.user.id);

                  setState(() {
                    isOpenSearch = chatRepository.filteredUserList.isNotEmpty;
                  });
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.grey_d9d9d9,
                ),
                controller: searchController),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                StreamBuilder<List<Room>>(
                    stream: context.read<ChatRepository>().roomsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Room> rooms = snapshot.data as List<Room>;

                        rooms.sort((room1, room2) => (room1.updatedAt ?? 0)
                            .compareTo(room2.updatedAt ?? 0));
                        return Column(
                          children: [
                            if (snapshot.hasData) ...generateChats(rooms)
                          ],
                        );
                      }

                      return Center(
                        child: AppAnimations.circleIndicator,
                      );
                    }),
                buildSearch()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() {
    final repository = context.read<ChatRepository>();
    final sizeOf = MediaQuery.sizeOf(context);

    return Container(
      alignment: Alignment.center,
      color: AppColors.black,
      child: AnimatedContainer(
        alignment: Alignment.center,
        margin: isOpenSearch ? const EdgeInsets.only(top: 20) : EdgeInsets.zero,
        padding: isOpenSearch
            ? const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
            : EdgeInsets.zero,
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        height: isOpenSearch
            ? 20 +
                (sizeOf.width * 0.1 + 10) * repository.filteredUserList.length
            : 0,
        decoration: BoxDecoration(
            color: AppColors.black_s2new_1A1A1A,
            borderRadius: BorderRadius.circular(10)),
        child: BlocBuilder<UserSearchCubit, UserSearchState>(
          builder: (context, state) {
            if (state is UserSearchSuccessState &&
                repository.filteredUserList.isNotEmpty) {
              return Column(children: generateFoundUsers());
            } else {
              return Center(
                child: Container(),
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> generateChats(List<Room> rooms) {
    return rooms
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
                    Dialogs.show(
                        context, Center(child: AppAnimations.circleIndicator));

                    Room? room = await chatRepository.roomWithUserExists(e.id);
                    room ??= await chatRepository.createRoomWithUser(e);

                    chatRepository.setActiveUser(e);

                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => ChatMessagesScreen(room: room!)));
                  }
                },
                userModel: e,
              ),
            ))
        .toList();
  }
}
