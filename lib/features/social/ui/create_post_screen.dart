import 'dart:io';

import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/create_post/create_post_cubit.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_avatar.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_text_button.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool buttonActive = false;
  final TextEditingController textController = TextEditingController();

  XFile? image;

  void pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    validate();
  }

  void validate() {
    buttonActive = image != null || textController.text.isNotEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listener: (context, state) {
        if (state is CreateLoadingState) {
          Dialogs.showModal(
              context,
              Center(
                child: AppAnimations.circleIndicator,
              ));
        } else {
          Dialogs.hide(context);
        }
        if (state is CreateSuccessState) {
          Navigator.pop(context);
        }
      },
      child: CustomScaffold(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallTextButton(
                text: 'Discard',
                onTap: () => Navigator.pop(context),
                type: SmallTextButtonType.withoutBackground,
              ),
              Text(
                'CREATE',
                style: AppFonts.font14w400,
              ),
              SmallTextButton(
                text: 'Publish',
                onTap: () => context
                    .read<CreatePostCubit>()
                    .createPost(textController.text, image),
                active: buttonActive,
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SmallAvatarWidget(
                      user: context.read<ProfileRepository>().user,
                    )),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - (24 * 2 + 32 + 12),
                  child: TextField(
                    onChanged: (v) => validate(),
                    maxLines: 12,
                    minLines: 1,
                    maxLength: 300,
                    controller: textController,
                    style: AppFonts.font16w400,
                    decoration: InputDecoration(
                        hintText: "What's on your mind?",
                        hintStyle: AppFonts.font16w400
                            .copyWith(color: AppColors.grey_727477),
                        border: InputBorder.none),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            image == null
                ? SizedBox(
                    height: 32,
                    child: TextButton(
                      onPressed: pickImage,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.black_s2new_1A1A1A,
                          foregroundColor: AppColors.black_s2new_1A1A1A,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 6)),
                      child: SvgPicture.asset(Assets.icons('attachment.svg')),
                    ),
                  )
                : Container(
                    width: MediaQuery.sizeOf(context).width - 48,
                    height: MediaQuery.sizeOf(context).width - 48,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(image!.path)),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.bottomLeft,
                  ),
            const SizedBox(height: 12,),
            image != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallTextButton(
                        type: SmallTextButtonType.withBackground,
                        backgroundColor: Colors.white,
                        text: 'Delete',
                        onTap: () {
                          image = null;
                          validate();
                        },
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
