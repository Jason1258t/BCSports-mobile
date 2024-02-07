import 'dart:io';
import 'dart:typed_data';

import 'package:bcsports_mobile/features/profile/bloc/edit_user/edit_user_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
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
  late final nameController;
  late final userNameController;

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
        body: BlocBuilder<EditUserCubit, EditUserState>(
            builder: (context, state) {
          if (state is EditUserSuccessState) {
            var user = RepositoryProvider.of<ProfileRepository>(context).user;

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
                                ? NetworkImage(user.avatarUrl ?? '')
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
                        : CircleAvatar(
                            radius: sizeOf.width * 0.20,
                            child: Image.file(File(image!.path), fit: BoxFit.fill,),
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
                          color: AppColors.grey_B3B3B3,
                          size: 50,
                        ),
                      ),
                    )
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
                    onTap: () async {
                      await BlocProvider.of<EditUserCubit>(context).editProfile(
                          nameController.text, userNameController.text, image);

                      RepositoryProvider.of<ProfileRepository>(context)
                          .setUser(user.id);

                      image = null;
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
