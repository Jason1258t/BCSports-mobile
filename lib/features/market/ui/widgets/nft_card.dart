import 'dart:ui';

import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketNftCard extends StatefulWidget {
  final NftModel nft;

  const MarketNftCard({super.key, required this.nft});

  @override
  State<MarketNftCard> createState() => MarketNftCardState();
}

class MarketNftCardState extends State<MarketNftCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MarketRepository>().loadNft();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            gradient: AppGradients.orange),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: Image.asset(
                  "assets/images/photo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 40,
              child: Text(
                widget.nft.name.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.font22w800ItalicAS
                    .copyWith(color: AppColors.yellow_F3D523, letterSpacing: 1),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 4),
              clipBehavior: Clip.hardEdge,
              height: 26,
              decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Text(
                    "goalkeeper".toUpperCase(),
                    style: AppFonts.font9w600.copyWith(color: AppColors.white),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 26,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Country",
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.font9w600
                                  .copyWith(color: AppColors.white),
                            ),
                            Text(
                              "Brazil".toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.font9w600
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 26,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Born",
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.font9w600
                                  .copyWith(color: AppColors.white),
                            ),
                            Text(
                              "21.01.2007".toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.font9w600
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
