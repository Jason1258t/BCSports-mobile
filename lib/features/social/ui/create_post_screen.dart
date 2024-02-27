import 'dart:typed_data';

import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/create_post/create_post_cubit.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_avatar.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_text_button.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
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
  CroppedFile? croppedImage;
  Uint8List? croppedImagesBytes;

  void pickImage() async {
    final localize = AppLocalizations.of(context)!;

    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    croppedImage = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: localize.crop, 
            toolbarColor: AppColors.background,
            toolbarWidgetColor: AppColors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            statusBarColor: AppColors.background,
            backgroundColor: AppColors.background,
            hideBottomControls: true,
            lockAspectRatio: true),
        IOSUiSettings(
          title: localize.crop, 
          aspectRatioLockEnabled: true,
          minimumAspectRatio: 1,
          doneButtonTitle: localize.done,
          cancelButtonTitle: localize.cansel,
        ),
      ],
    );

    if (croppedImage == null) {
      image = null;
    } else {
      croppedImagesBytes = await croppedImage!.readAsBytes();
    }
    validate();
  }

  void validate() {
    buttonActive = image != null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

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
        resize: true,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallTextButton(
                text: localize.discard,
                onTap: () => Navigator.pop(context),
                type: SmallTextButtonType.withoutBackground,
              ),
              Text(
                localize.create,
                style: AppFonts.font14w400,
              ),
              SmallTextButton(
                text: localize.publish,
                onTap: () => context
                    .read<CreatePostCubit>()
                    .createPost(textController.text, croppedImagesBytes),
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
                    autofocus: true,
                    controller: textController,
                    style: AppFonts.font16w400,
                    decoration: InputDecoration(
                        hintText: localize.mind,
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
                ? Container()
                : Container(
                    width: MediaQuery.sizeOf(context).width - 48,
                    height: MediaQuery.sizeOf(context).width - 48,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(croppedImagesBytes!),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.bottomLeft,
                  ),
            image == null
                ? const Spacer()
                : const SizedBox(
                    height: 24,
                  ),
            CustomTextButton(
              prefixIcon: SvgPicture.asset(
                Assets.icons('attachment.svg'),
                color: AppColors.background,
                width: 24,
                height: 24,
              ),
              text: localize.choose_photo,
              onTap: pickImage,
              isActive: true,
              color: image == null ? AppColors.primary : AppColors.white,
              height: 52,
            ),
            const SizedBox(
              height: 32,
            ),
            // image != null
            //     ? Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           SmallTextButton(
            //             type: SmallTextButtonType.withBackground,
            //             backgroundColor: Colors.white,
            //             text: localize.delete,
            //             onTap: () {
            //               image = null;
            //               croppedImage = null;
            //               croppedImagesBytes = null;
            //               validate();
            //             },
            //           ),
            //         ],
            //       )
            //     : Container()
          ],
        ),
      ),
    );
  }
}
