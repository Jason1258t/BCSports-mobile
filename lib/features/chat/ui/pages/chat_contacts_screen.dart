import 'package:bcsports_mobile/features/chat/bloc/user_search_cubit.dart';
import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: SingleChildScrollView(
          child: Column(
        children: [
          CustomTextFormField(
              onChange: (v) {
                context.read<UserSearchCubit>().searchByString(v ?? '');
              },
              prefixIcon: const Icon(Icons.search),
              controller: searchController),
          const SizedBox(
            height: 18,
          ),
          BlocBuilder<UserSearchCubit, UserSearchState>(
            builder: (context, state) {
              if (state is UserSearchSuccessState) {
                return Column(
                    children: chatRepository.filteredUserList
                        .map((e) => Text(
                              e.username,
                              style: AppFonts.font12w400,
                            ))
                        .toList());
              } else {
                return Center(
                  child: AppAnimations.circleIndicator,
                );
              }
            },
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      )),
    );
  }
}

class ChatCardPreviewWidget extends StatelessWidget {
  const ChatCardPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}
