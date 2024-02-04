import 'package:bcsports_mobile/features/auth/bloc/auth/auth_cubit.dart';
import 'package:bcsports_mobile/features/auth/ui/widgets/logo.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/validator.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_with_icon.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool passwordObscured = true;

  bool agree = false;
  bool buttonActive = false;

  void validate() {
    buttonActive = _formKey.currentState!.validate() && agree;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is AuthInProcess) {
      Dialogs.showModal(context, Center(child: AppAnimations.circleIndicator,));
    } else {
      Dialogs.hide(context);
    }
    if (state is AuthFailState) print(state.e);
  },
  child: CustomScaffold(
        body: Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 80), child: LogoWidget()),
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
                labelText: 'Email address',
                hintText: 'Email',
                prefixIcon: Container(
                  padding: const EdgeInsets.only(right: 5),
                  height: 20,
                  child: SvgPicture.asset(
                    Assets.icons('email.svg'),
                  ),
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
                labelText: 'Password',
                hintText: 'Password',
                prefixIcon: Container(
                  padding: const EdgeInsets.only(right: 5),
                  child: SvgPicture.asset(
                    Assets.icons('lock.svg'),
                  ),
                ),
                suffixIcon: InkWell(
                  child: SvgPicture.asset(Assets.icons('eye-close.svg')),
                  onTap: () {
                    setState(() {
                      passwordObscured = !passwordObscured;
                    });
                  },
                ),
                obscured: passwordObscured,
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                children: [
                  FlutterSwitch(
                      width: 40,
                      height: 20,
                      value: agree,
                      padding: 3,
                      toggleSize: 14,
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.black_s2new_1A1A1A,
                      onToggle: (value) {
                        setState(() {
                          agree = value;
                          validate();
                        });
                      }),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(TextSpan(
                          text: 'forgot password?',
                          style: AppFonts.font12w400,
                          recognizer: TapGestureRecognizer()..onTap = () {}))
                    ],
                  )
                  // Text.rich(TextSpan(children: [
                  //   TextSpan(
                  //       text: 'I agree to the ', style: AppFonts.font12w400),
                  //   TextSpan(
                  //       recognizer: TapGestureRecognizer()..onTap = () {},
                  //       text: 'terms and conditions',
                  //       style: AppFonts.font12w400.copyWith(
                  //           decoration: TextDecoration.underline,
                  //           decorationThickness: 3,
                  //           decorationColor: Colors.white)),
                  // ]))
                ],
              ),
              const SizedBox(
                height: 55,
              ),
              CustomTextButton(
                text: 'Sign up',
                onTap: () {
                  context.read<AuthCubit>().signUpWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                },
                isActive: buttonActive,
              ),
              const SizedBox(
                height: 20,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'Already have an account? ',
                    style: AppFonts.font12w400),
                TextSpan(
                    text: 'Sign in',
                    style: AppFonts.font12w600,
                    recognizer: TapGestureRecognizer()..onTap = () {}),
              ])),
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
                    onTap: () {},
                    isActive: true,
                  )),
                ],
              )
            ],
          ),
        )
      ],
    )),
);
  }
}
