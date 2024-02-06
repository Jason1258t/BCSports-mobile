import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

enum SmallTextButtonType { withBackground, withoutBackground }

class SmallTextButton extends StatelessWidget {
  const SmallTextButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.active = true,
      this.type = SmallTextButtonType.withBackground});

  final String text;
  final VoidCallback onTap;
  final bool active;
  final SmallTextButtonType type;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = AppFonts.font14w400.copyWith(
        color: type == SmallTextButtonType.withBackground
            ? AppColors.background
            : AppColors.blueLink);

    final Color background;

    if (type == SmallTextButtonType.withBackground) {
      background = active ? AppColors.primary : AppColors.black_s2new_1A1A1A;
    } else {
      background = Colors.transparent;
    }

    return SizedBox(
      height: 24,
      child: TextButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: background,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12)
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
