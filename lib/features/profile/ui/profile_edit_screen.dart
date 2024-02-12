import 'dart:io';

import 'package:bcsports_mobile/features/profile/bloc/edit_user/edit_user_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
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

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final repository = RepositoryProvider.of<ProfileRepository>(context);

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
                'Edit Profile',
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
                Stack(
                  children: [
                    image == null
                        ? CircleAvatar(
                            backgroundColor: user.avatarColor,
                            radius: sizeOf.width * 0.20,
                            backgroundImage: user.avatarUrl != null
                                ? NetworkImage(user.avatarUrl!)
                                : null,
                            child: user.avatarUrl == null
                                ? Center(
                                    child: Text(
                                      (user.displayName ?? user.username)[0]
                                          .toUpperCase(),
                                      style: AppFonts.font64w400,
                                    ),
                                  )
                                : Container(),
                          )
                        : Container(
                            width: sizeOf.width * 0.4,
                            height: sizeOf.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: FileImage(File(image!.path)),
                                  fit: BoxFit.cover
                                )
                            ),
                            // child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(1000),
                            //     child: Image.file(File(image!.path))),
                          ),
                    Container(
                      width: sizeOf.width * 0.40,
                      height: sizeOf.width * 0.40,
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
                        width: sizeOf.width * 0.40,
                        height: sizeOf.width * 0.40,
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomTextFormField(
                      controller: nameController,
                      labelText: 'Name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: userNameController,
                      labelText: 'Username',
                    ),
                  ],
                ),
                CustomTextButton(
                    text: 'Save',
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
