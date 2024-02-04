import 'dart:ui';

import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/gradients.dart';
import 'package:flutter/material.dart';

class MarketNftCard extends StatefulWidget {
  final NftModel nft;

  const MarketNftCard({super.key, required this.nft});

  @override
  State<MarketNftCard> createState() => MarketNftCardState();
}

class MarketNftCardState extends State<MarketNftCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: AppGradients.orange
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(11)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  
                  Positioned(
                    bottom: 10,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 32,
                      width: 130,
                      decoration: BoxDecoration(
                        color: AppColors.black_222232.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      alignment: Alignment.center,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Text(
                          "Take it",
                          style: AppFonts.font14w500
                              .copyWith(color: AppColors.yellow_F3D523),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            widget.nft.name,
            style: AppFonts.font14w400.copyWith(color: AppColors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.nft.price.toString(),
            style: AppFonts.font14w500.copyWith(color: AppColors.yellow_F3D523),
          )
        ],
      ),
    );
  }
}
