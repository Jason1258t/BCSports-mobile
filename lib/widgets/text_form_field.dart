import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.validator,
      required this.controller,
      this.prefixIcon,
      this.hintText,
      this.labelText,
      this.obscured = false,
      this.suffixIcon,
      this.keyboardType,
      this.onChange,
      this.initValue,
      this.onTap,
      this.padding,
      this.backgroundColor,
      this.borderRadius,
      this.showCursor});

  final String? Function(String?)? validator;
  final TextEditingController controller;

  final Widget? prefixIcon;
  final String? hintText;
  final String? labelText;
  final bool obscured;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String?)? onChange;
  final String? initValue;
  final Function()? onTap;
  final bool? showCursor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppFonts.font14w400.copyWith(color: AppColors.grey_B4B4B4),
          ),
          const SizedBox(
            height: 10,
          )
        ],
        Container(
          decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.black_s2new_1A1A1A,
              borderRadius:borderRadius ??  BorderRadius.circular(9)),
          padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          alignment: Alignment.center,
          child: TextFormField(
            showCursor: showCursor,
            onTap: onTap,
            onChanged: onChange,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscured,
            initialValue: initValue,
            style: AppFonts.font16w500,
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                errorStyle: const TextStyle(
                  fontSize: 0,
                ),
                prefixIconConstraints: const BoxConstraints(
                  maxWidth: 25,
                  maxHeight: 20,
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 20,
                  maxHeight: 20,
                ),
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.all(2),
                hintText: hintText,
                hintStyle:
                    AppFonts.font16w500.copyWith(color: AppColors.grey_B4B4B4),
                border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
