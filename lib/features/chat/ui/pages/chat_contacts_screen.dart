import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
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
          ChatCardPreviewWidget(),
          ChatCardPreviewWidget(),
          ChatCardPreviewWidget(),
          ChatCardPreviewWidget(),
          // SliverList.builder(itemBuilder: itemBuilder)
        ],
      ),
    );
  }
}

class ChatCardPreviewWidget extends StatelessWidget {
  const ChatCardPreviewWidget({super.key});

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
