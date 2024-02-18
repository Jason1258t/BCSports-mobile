import 'dart:ui';

import 'package:bcsports_mobile/features/market/bloc/buy/buy_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BuyNftPopup extends StatefulWidget {
  final MarketItemModel product;

  const BuyNftPopup({super.key, required this.product});

  @override
  State<BuyNftPopup> createState() => _BuyNftPopupState();
}

class _BuyNftPopupState extends State<BuyNftPopup> {
  bool agree = false;

  void onBuyTap() {
    context.read<BuyNftCubit>().buyNft(
          widget.product,
        );
  }

  bool isActive() =>
      context.read<ProfileRepository>().user.evmBill >=
          widget.product.currentPrice &&
      agree;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
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
                  "Buy", // TODO
                  style: AppFonts.font24w500.copyWith(color: AppColors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                      border: Border.all(width: 1, color: AppColors.primary)),
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
                            "${widget.product.currentPrice} ETH",
                            style: AppFonts.font17w500
                                .copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                     
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Available balance", // TODO
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
                      localize.agree_terms,
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
                    text: "Place a Bid", // TODO
                    onTap: onBuyTap,
                    isActive: isActive())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
