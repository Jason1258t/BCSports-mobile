import 'package:bcsports_mobile/features/chat/bloc/user_search_cubit.dart';
import 'package:bcsports_mobile/features/chat/bloc/user_search_cubit.dart';
import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/chat/ui/widgets/small_user_card.dart';
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
                setState(() {
                  isOpenSearch = true;
                });
              },
              prefixIcon: const Icon(Icons.search),
              controller: searchController),
          AnimatedContainer(
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
                    chatRepository.filteredUserList.isNotEmpty) {
                  return Column(
                      children: chatRepository.filteredUserList
                          .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SmallUserCard(
                                  onTap: () {},
                                  userModel: e,
                                ),
                          ))
                          .toList());
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
          const SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 18,
              ),
            ],
          )),
        ],
      ),
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
