import 'dart:ui';

import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/gradients.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarketNftCard extends StatefulWidget {
  final NftModel nft;
  final Function onTap;

  const MarketNftCard({super.key, required this.nft, required this.onTap});

  @override
  State<MarketNftCard> createState() => MarketNftCardState();
}

class MarketNftCardState extends State<MarketNftCard> {
  void _onTap() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cardSize = (size.width - 18 * 2 - 17) / 2;
    final imgSize = cardSize - 8;
    final topMargin = imgSize * 0.17;

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            gradient: AppGradients.orange),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  left: 3,
                  top: topMargin + 52,
                  child: SizedBox(
                    width: 57,
                    child: Transform.rotate(
                      angle: -1.57,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.nft.club,
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts.font8w400
                            .copyWith(color: AppColors.white.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  child: Stack(
                    children: [
                      FadeInImage(
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          placeholder: const AssetImage(
                            "assets/images/noname.png",
                          ),
                          image: NetworkImage(widget.nft.previewImagePath)),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  SizedBox(
                    height: 42,
                    child: Text(
                      widget.nft.name.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.font22w800ItalicAS.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1,
                          height: 0.9),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    clipBehavior: Clip.hardEdge,
                    height: 26,
                    decoration: BoxDecoration(
                        color: AppColors.greyStrange,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Text(
                      widget.nft.position.toUpperCase(),
                      style:
                          AppFonts.font9w600.copyWith(color: AppColors.white),
                    ),
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
                              color: AppColors.greyStrange,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Country",
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.font9w300
                                    .copyWith(color: AppColors.white),
                              ),
                              Text(
                                widget.nft.country.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.font9w600
                                    .copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
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
                              color: AppColors.greyStrange,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Born",
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.font9w300
                                    .copyWith(color: AppColors.white),
                              ),
                              Text(
                                DateFormat('dd.MM.yyyy')
                                    .format(widget.nft.birthday)
                                    .toString()
                                    .toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.font9w600
                                    .copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
