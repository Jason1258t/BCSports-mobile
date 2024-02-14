import 'dart:ui';

import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:flutter/material.dart';

class CanselLotPopup extends StatefulWidget {
  final Function onAccept;

  const CanselLotPopup({super.key, required this.onAccept});

  @override
  State<CanselLotPopup> createState() => _CanselLotPopupState();
}

class _CanselLotPopupState extends State<CanselLotPopup> {
  final String message = "Are you sure you want to cancel the sale?";
  final String message2 =
      "The NFT will be removed from the marketplace and returned to your inventory.";

  void _onCansel() {
    Navigator.of(context).pop();
  }

  void _onAccept() {
    widget.onAccept();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
      child: Center(
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.black_s2new_1A1A1A,
                borderRadius: BorderRadius.circular(22)),
            padding: const EdgeInsets.all(23),
            width: size.width - 44,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppFonts.font24w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  message2,
                  textAlign: TextAlign.center,
                  style: AppFonts.font12w400.copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButton(
                      text: "No",
                      onTap: _onCansel,
                      width: size.width * 0.35,
                      height: 52,
                      isActive: true,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomTextButton(
                      text: "yes",
                      onTap: _onAccept,
                      width: size.width * 0.35,
                      height: 52,
                      isActive: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
