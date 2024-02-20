import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

enum SmallTextButtonType {
  withBackground,
  withoutBackground,
  withBackgroundReverse
}

class SmallTextButton extends StatelessWidget {
  const SmallTextButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.active = true,
      this.type = SmallTextButtonType.withBackground, this.backgroundColor});

  final String text;
  final VoidCallback onTap;
  final bool active;
  final Color? backgroundColor;
  final SmallTextButtonType type;

  @override
  Widget build(BuildContext context) {
    Color textColor;

    if (type == SmallTextButtonType.withBackground) {
      textColor = AppColors.background;
    } else if (type == SmallTextButtonType.withoutBackground) {
      textColor = AppColors.blueLink;
    } else if (type == SmallTextButtonType.withBackgroundReverse) {
      textColor = AppColors.primary;
    } else {
      textColor = Colors.white;
    }

    final TextStyle textStyle = AppFonts.font14w400.copyWith(color: textColor);

    final Color background;

    if (type == SmallTextButtonType.withBackground) {
      background = active ? AppColors.primary : AppColors.black_s2new_1A1A1A;
    } else if (type == SmallTextButtonType.withBackgroundReverse) {
      background =
          active ? AppColors.black_s2new_1A1A1A : AppColors.black_s2new_1A1A1A;
    } else {
      background = Colors.transparent;
    }

    return SizedBox(
      height: 24,
      child: TextButton(
        onPressed: active ? onTap : () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? background,
            foregroundColor: backgroundColor ?? background,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12)),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
