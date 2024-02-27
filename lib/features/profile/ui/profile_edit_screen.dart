import 'dart:io';

import 'package:bcsports_mobile/features/profile/bloc/edit_user/edit_user_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController userNameController;

  XFile? image;

  Future<void> pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  void initState() {
    super.initState();

    final repository = RepositoryProvider.of<ProfileRepository>(context);

    nameController = TextEditingController(text: repository.user.displayName);
    userNameController = TextEditingController(text: repository.user.username);
  }

  Widget buildAvatar(UserModel user) {
    final size = MediaQuery.sizeOf(context);
    final bool showKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;

    double avatarRadius = showKeyboard ? 40 : size.width * 0.20;

    return Stack(
      children: [
        image == null
            ? CircleAvatar(
                backgroundColor: user.avatarColor,
                radius: avatarRadius,
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? Center(
                        child: Text(
                          (user.displayName ?? user.username)[0].toUpperCase(),
                          style: AppFonts.font64w400,
                        ),
                      )
                    : Container(),
              )
            : Container(
                width: avatarRadius * 2,
                height: avatarRadius * 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: FileImage(File(image!.path)),
                        fit: BoxFit.cover)),
              ),
        Container(
          width: avatarRadius * 2,
          height: avatarRadius * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            color: Colors.black45,
          ),
        ),
        InkWell(
          onTap: () async {
            await pickImage();
            setState(() {});
          },
          borderRadius: BorderRadius.circular(100),
          child: Ink(
            width: avatarRadius * 2,
            height: avatarRadius * 2,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              color: AppColors.white,
              size: showKeyboard ? 30 : 50,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final repository = RepositoryProvider.of<ProfileRepository>(context);

    final localize = AppLocalizations.of(context)!;

    return CustomScaffold(
        resize: true,
        color: AppColors.black,
        padding: EdgeInsets.all(sizeOf.width * 0.05),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              ButtonBack(onTap: () {
                Navigator.pop(context);
              }),
              Text(
                localize.edit_profile,
                style: AppFonts.font18w600,
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
        ),
        body: BlocConsumer<EditUserCubit, EditUserState>(
            listener: (context, state) {
          if (state is EditUserSuccessState) {
            repository.setUser(repository.user.id);
            image = null;
          }
          if (state is EditUserFailState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(AppSnackBars.snackBar(state.e.toString()));
          }
        }, builder: (context, state) {
          if (state is! EditUserLoadingState) {
            var user = repository.user;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildAvatar(user),
                Column(
                  children: [
                    CustomTextFormField(
                      controller: nameController,
                      labelText: localize.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: userNameController,
                      labelText: localize.username,
                    ),
                  ],
                ),
                CustomTextButton(
                    text: localize.save,
                    height: 52,
                    onTap: () {
                      BlocProvider.of<EditUserCubit>(context).editProfile(
                          nameController.text, userNameController.text, image);
                    },
                    isActive: true)
              ],
            );
          } else {
            return Center(
              child: AppAnimations.circleIndicator,
            );
          }
        }));
  }
}
