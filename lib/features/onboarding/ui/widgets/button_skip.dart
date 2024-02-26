import 'package:bcsports_mobile/features/onboarding/bloc/cubit/onboarding_cubit.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonSkip extends StatefulWidget {
  const ButtonSkip({super.key});

  @override
  State<ButtonSkip> createState() => _ButtonSkipState();
}

class _ButtonSkipState extends State<ButtonSkip> {
  void onTap() {
    context.read<OnboardingCubit>().skipAllPages();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Text(
            localize.skip,
            style: AppFonts.font16w600.copyWith(color: AppColors.white),
          ),
        )
      ],
    );
  }
}
