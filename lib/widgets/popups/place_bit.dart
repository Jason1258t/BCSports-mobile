import 'dart:ui';

import 'package:bcsports_mobile/features/market/bloc/place_bid/place_bid_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PlaceBitPopup extends StatefulWidget {
  final NftModel nft;

  const PlaceBitPopup({super.key, required this.nft});

  @override
  State<PlaceBitPopup> createState() => _PlaceBitPopupState();
}

class _PlaceBitPopupState extends State<PlaceBitPopup> {
  bool agree = false;
  double extraBid = 0;

  void onPlaceBidTap() {
    context.read<PlaceBidCubit>().updateBid(widget.nft, 123123);
  }

  void increaseBet() {
    setState(() {
      extraBid += 10;
    });
  }

  bool isActive() =>
      context.read<ProfileRepository>().user.evmBill + extraBid >=
          widget.nft.currentBit &&
      agree;

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
                color: AppColors.black_1A1A1A,
                borderRadius: BorderRadius.circular(22)),
            padding: const EdgeInsets.all(23),
            width: size.width - 44,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Place a bid",
                  style: AppFonts.font24w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 200),
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                      border:
                          Border.all(width: 1, color: AppColors.yellow_F3D523)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset("assets/icons/eth.svg"),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${widget.nft.currentBit + extraBid} ETH",
                            style: AppFonts.font17w500
                                .copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                      Material(
                        color: AppColors.yellow_F3D523,
                        borderRadius: BorderRadius.circular(1000),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(1000),
                          onTap: increaseBet,
                          child: Container(
                            alignment: Alignment.center,
                            width: 39,
                            height: 39,
                            child: Text(
                              "+",
                              style: AppFonts.font24w500
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Available balance",
                  style: AppFonts.font12w400.copyWith(color: AppColors.white),
                ),
                Text(
                  "${profileRepository.user.evmBill} ETH",
                  style: AppFonts.font12w400
                      .copyWith(color: AppColors.grey_B4B4B4),
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
                    text: "Place a Bid",
                    onTap: onPlaceBidTap,
                    isActive: isActive())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
