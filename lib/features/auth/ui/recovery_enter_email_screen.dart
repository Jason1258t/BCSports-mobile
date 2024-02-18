import 'package:bcsports_mobile/features/auth/bloc/reset_password/reset_password_cubit.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/validator.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  bool buttonActive = false;

  void validate() {
    buttonActive = _formKey.currentState!.validate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoadingState) {
          Dialogs.showModal(
              context,
              Center(
                child: AppAnimations.circleIndicator,
              ));
        } else {
          Dialogs.hide(context);
        }
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar('Успешно, можете вернуться'));
        }
      },
      child: CustomScaffold(
          resize: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonBack(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  localize.forgot_password,
                  style: AppFonts.font18w600,
                ),
                const SizedBox(
                  width: 46,
                )
              ],
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                localize.forgot_your_password,
                style: AppFonts.font23w500,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 225,
                child: Text(
                  localize.enter_registered_email,
                  style: AppFonts.font16w400,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: CustomTextFormField(
                  onChange: (b) {
                    validate();
                  },
                  controller: emailController,
                  validator: Validator.emailValidator,
                  hintText: localize.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Container(
                    padding: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      Assets.icons('email.svg'),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              CustomTextButton(
                text: localize.send_recovery,
                onTap: () {
                  context
                      .read<ResetPasswordCubit>()
                      .resetPassword(emailController.text.trim());
                },
                isActive: buttonActive,
              ),
              const SizedBox(height: 20,)
            ],
          )),
    );
  }
}
