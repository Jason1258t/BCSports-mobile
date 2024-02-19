import 'package:bcsports_mobile/features/auth/bloc/auth/auth_cubit.dart';
import 'package:bcsports_mobile/features/auth/ui/widgets/logo.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/validator.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_with_icon.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool passwordObscured = true;

  bool buttonActive = false;

  void validate() {
    buttonActive = _formKey.currentState!.validate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInProcess) {
          Dialogs.showModal(
              context,
              Center(
                child: AppAnimations.circleIndicator,
              ));
        } else {
          Dialogs.hide(context);
        }
        if (state is AuthFailState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar(state.e.toString()));
        }
      },
      child: CustomScaffold(
          canPop: false,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: LogoWidget()),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        onChange: (b) {
                          validate();
                        },
                        validator: Validator.emailValidator,
                        controller: emailController,
                        labelText: localize.email_address,
                        hintText: localize.email,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: SvgPicture.asset(
                          Assets.icons('email.svg'),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      CustomTextFormField(
                        onChange: (b) {
                          validate();
                        },
                        controller: passwordController,
                        validator: Validator.passwordValidator,
                        labelText: localize.password,
                        hintText: localize.password,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: SvgPicture.asset(
                          Assets.icons('lock.svg'),
                        ),
                        suffixIcon: InkWell(
                          child: SvgPicture.asset(
                            passwordObscured
                                ? Assets.icons('uil_eye-slash.svg')
                                : Assets.icons('uil_eye.svg'),
                          ),
                          onTap: () {
                            setState(() {
                              passwordObscured = !passwordObscured;
                            });
                          },
                        ),
                        obscured: passwordObscured,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text.rich(TextSpan(
                              text: localize.forgot_password,
                              style: AppFonts.font12w400,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, AppRouteNames.recovery);
                                }))
                        ],
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      CustomTextButton(
                        text: localize.sign_in,
                        onTap: () {
                          context.read<AuthCubit>().signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                        },
                        isActive: buttonActive,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ButtonWithIcon(
                            height: 40,
                            text: 'Google',
                            icon: SvgPicture.asset(Assets.icons('google.svg')),
                            onTap: () {
                              context.read<AuthCubit>().signInWithGoogle();
                            },
                            isActive: true,
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: ButtonWithIcon(
                            height: 40,
                            text: 'Apple',
                            icon: SvgPicture.asset(Assets.icons('apple.svg')),
                            onTap: () {
                              context.read<AuthCubit>().signInWithApple();
                            },
                            isActive: true,
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "${localize.no_acc} ",
                            style: AppFonts.font12w400),
                        TextSpan(
                            text: localize.sign_up,
                            style: AppFonts.font12w600,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, AppRouteNames.registration);
                              }),
                      ])),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
