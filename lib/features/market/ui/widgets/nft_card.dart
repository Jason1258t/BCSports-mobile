import 'dart:ui';

import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/gradients.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarketNftCard extends StatefulWidget {
  final NftModel nft;

  const MarketNftCard({super.key, required this.nft});

  @override
  State<MarketNftCard> createState() => MarketNftCardState();
}

class MarketNftCardState extends State<MarketNftCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cardSize = (size.width - 18 * 2 - 17) / 2;
    final imgSize = cardSize - 8;
    final topMargin = imgSize * 0.17;

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/market/details', arguments: {'nft': widget.nft});
      },
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
                  top: topMargin + 57,
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
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Text(
                      widget.nft.name.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.font22w800ItalicAS.copyWith(
                          color: AppColors.primary, letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    clipBehavior: Clip.hardEdge,
                    height: 26,
                    decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Text(
                          widget.nft.position.toUpperCase(),
                          style: AppFonts.font9w600
                              .copyWith(color: AppColors.white),
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
                                    DateFormat('dd.MM.yyyy')
                                        .format(widget.nft.birthday)
                                        .toString()
                                        .toUpperCase(),
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
          ],
        ),
      ),
    );
  }
}
