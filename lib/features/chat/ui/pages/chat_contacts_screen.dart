import 'package:bcsports_mobile/features/chat/bloc/user_search_cubit.dart';
import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/chat/ui/pages/chat_messages_screen.dart';
import 'package:bcsports_mobile/features/chat/ui/widgets/chat_preview.dart';
import 'package:bcsports_mobile/features/chat/ui/widgets/small_user_card.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
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

  final String title = "Messages";

  bool isOpenSearch = false;

  @override
  Widget build(BuildContext context) {
    final ProfileRepository profileRepository =
        context.read<ProfileRepository>();

    final ChatRepository chatRepository = context.read<ChatRepository>();

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
                borderRadius: BorderRadius.circular(32),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onChange: (v) {
                context.read<UserSearchCubit>().searchByString(
                    v == '' ? '123412dfasdaf' : v!, profileRepository.user.id);
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
                  isOpenSearch = true;
                });
              },
              prefixIcon:  Icon(Icons.search, color: AppColors.grey_d9d9d9,),
              controller: searchController),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Conversation",
                      style:
                          AppFonts.font16w400.copyWith(color: AppColors.white),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    StreamBuilder<List<Room>>(
                        stream: context.read<ChatRepository>().roomsStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              if (snapshot.hasData) ...generateChats(snapshot)
                            ],
                          );
                        }),
                  ],
                )),
              ),
              buildSearch()
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearch() {
    final repository = context.read<ChatRepository>();
    final sizeOf = MediaQuery.sizeOf(context);
    return Container(
      color: AppColors.black,
      child: AnimatedContainer(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        height: isOpenSearch ? sizeOf.height * 0.5 : 0,
        decoration: BoxDecoration(
            color: AppColors.black_s2new_1A1A1A,
            borderRadius: BorderRadius.circular(10)),
        child: BlocBuilder<UserSearchCubit, UserSearchState>(
          builder: (context, state) {
            if (state is UserSearchSuccessState &&
                repository.filteredUserList.isNotEmpty) {
              return Column(children: generateFoundUsers());
            } else if (state is UserSearchSuccessState &&
                repository.filteredUserList.isEmpty) {
              return const Text('Тo result');
            } else {
              return Center(
                child: AppAnimations.circleIndicator,
              );
            }
          },
        ),
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
