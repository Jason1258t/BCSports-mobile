import 'dart:html';

import 'package:bcsports_mobile/features/chat/bloc/user_search_cubit.dart';
import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatContactsScreen extends StatefulWidget {
  const ChatContactsScreen({super.key});

  @override
  State<ChatContactsScreen> createState() => _ChatContactsScreenState();
}

class _ChatContactsScreenState extends State<ChatContactsScreen> {
  final TextEditingController searchController = TextEditingController();

  final String title = "Contacts";

  @override
  Widget build(BuildContext context) {
    final ChatRepository chatRepository = context.read<ChatRepository>();

    return CustomScaffold(
      color: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: AppColors.black,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              floating: true,
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
              )),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 18,
            ),
          ),
          SliverToBoxAdapter(
              child: CustomTextFormField(
                  prefixIcon: Icon(Icons.search),
                  controller: searchController)),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 18,
            ),
          ),

          SliverToBoxAdapter(
            child: BlocBuilder<UserSearchCubit, UserSearchState>(
              builder: (context, state) {
                if (state is UserSearchLoadingState) {
                  return Center(
                    child: AppAnimations.circleIndicator,
                  );
                } else if (state is UserSearchSuccessState) {
                  return SliverList.builder(itemBuilder: (context, index) {
                    return ChatCardPreviewWidget(
                        user: chatRepository.socialUserList[index]);
                  });
                }

                return Center(
                  child: Text("Sorry smth went wrong"),
                );
              },
            ),
          ),

          // SliverList.builder(itemBuilder: itemBuilder)
        ],
      ),
    );
  }
}

class ChatCardPreviewWidget extends StatelessWidget {
  final UserModel user;

  const ChatCardPreviewWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRouteNames.chatMessages);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primary),
                width: 48,
                height: 48,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: AppFonts.font14w500.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Last message",
                    style: AppFonts.font12w400.copyWith(color: AppColors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
