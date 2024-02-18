import 'package:bcsports_mobile/features/auth/bloc/set_name/create_display_name_cubit.dart';
import 'package:bcsports_mobile/features/auth/ui/widgets/logo.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDisplayNameScreen extends StatefulWidget {
  const CreateDisplayNameScreen({super.key});

  @override
  State<CreateDisplayNameScreen> createState() =>
      _CreateDisplayNameScreenState();
}

class _CreateDisplayNameScreenState extends State<CreateDisplayNameScreen> {
  final nameController = TextEditingController();
  bool buttonActive = false;

  void validateName(String? value) {
    setState(() {
      buttonActive = (value ?? '').trim().length > 2;
    });
  }

  void completeRegister() {
    Navigator.pushReplacementNamed(context, AppRouteNames.onboarding);
  }

  void setName() async {
    context
        .read<CreateDisplayNameCubit>()
        .createName(nameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateDisplayNameCubit, CreateDisplayNameState>(
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
          completeRegister();
        }
      },
      child: CustomScaffold(
          body: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 80, bottom: 32), child: LogoWidget()),
          Row(
            children: [
              Text(
                'Your name',
                style: AppFonts.font24w500,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            controller: nameController,
            hintText: 'name',
            onChange: validateName,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextButton(text: 'Done', onTap: setName, isActive: buttonActive)
        ],
      )),
    );
  }
}
