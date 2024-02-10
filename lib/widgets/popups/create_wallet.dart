import 'dart:ui';

import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateWalletPopup extends StatefulWidget {
  const CreateWalletPopup({super.key});

  @override
  State<CreateWalletPopup> createState() => _CreateWalletPopupState();
}

class _CreateWalletPopupState extends State<CreateWalletPopup> {
  bool agree = false;
  final String message =
      "You need to connect your wallet first to sign messages and send transaction to Ethereum network";

  void onCansel() {
    Navigator.of(context).pop();
  }

  void onCreateWallet() {}

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: AppColors.white_FFF7C7,
                      borderRadius: BorderRadius.circular(1000),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(1000),
                        onTap: onCansel,
                        child: Container(
                            padding: const EdgeInsets.all(13),
                            child: SvgPicture.asset(
                              "assets/icons/cross.svg",
                              width: 13,
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white_FFF7C7,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/wallet.svg',
                      width: 27,
                    )),
                const SizedBox(
                  height: 42,
                ),
                SizedBox(
                  width: size.width * 0.64,
                  child: Text(
                    message,
                    style: AppFonts.font17w500
                        .copyWith(color: AppColors.white, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                Row(
                  children: [
                    CustomTextButton(
                        height: 44,
                        width: size.width * 0.38,
                        text: "Connect wallet",
                        onTap: onCreateWallet,
                        isActive: true),
                    CustomTextButton(
                        height: 44,
                        text: "Cansel",
                        width: size.width * 0.38,
                        onTap: onCansel,
                        isActive: false)
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
