import 'dart:ui';

import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SellNftPopup extends StatefulWidget {
  final NftModel nft;

  const SellNftPopup({super.key, required this.nft});

  @override
  State<SellNftPopup> createState() => _SellNftPopupState();
}

class _SellNftPopupState extends State<SellNftPopup> {
  final TextEditingController _priceController = TextEditingController();

  bool agree = false;

  // void onPlaceBidTap() {
  //   context
  //       .read<PlaceBidCubit>()
  //       .updateBid(widget.nft, extraBid + widget.nft.currentBit);
  // }

  bool isActive() => agree;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final ProfileRepository profileRepository =
        context.read<ProfileRepository>();

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
                  "Set a price",
                  style: AppFonts.font24w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  controller: _priceController,
                  prefixIcon: SvgPicture.asset("assets/icons/eth.svg"),
                  backgroundColor: AppColors.black_262627,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterSwitch(
                        width: 40,
                        height: 20,
                        value: agree,
                        padding: 3,
                        toggleSize: 14,
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.grey_d9d9d9,
                        toggleColor: Colors.black,
                        onToggle: (value) {
                          setState(() {
                            agree = value;
                          });
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "I agree to the terms and conditions",
                      style:
                          AppFonts.font10w500.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 27,
                ),
                CustomTextButton(
                    width: 170,
                    height: 49,
                    text: "Put up for sale",
                    onTap: () {},
                    isActive: isActive())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
