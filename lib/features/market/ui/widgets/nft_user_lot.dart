import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/gradients.dart';
import 'package:flutter/material.dart';

class NftUserLot extends StatefulWidget {
  final MarketItemModel product;
  final Function onTap;

  const NftUserLot({super.key, required this.product, required this.onTap});

  @override
  State<NftUserLot> createState() => NftUserLotState();
}

class NftUserLotState extends State<NftUserLot> {
  void _onTap() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cardSize = (size.width - 18 * 2 - 17) / 2;
    final imgSize = cardSize - 8;
    final topMargin = imgSize * 0.17;
    final nft = widget.product.nft;

    final localize = AppLocalizations.of(context)!;
    final bottomBtnText = localize.cancel_lot;

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
                        nft.club,
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
                          image: NetworkImage(nft.previewImagePath)),
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
                      nft.name.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.font22w800ItalicAS.copyWith(
                          color: AppColors.white,
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
                      "${widget.product.currentPrice} ETH".toUpperCase(),
                      style:
                          AppFonts.font9w600.copyWith(color: AppColors.white),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: 26,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Text(
                      bottomBtnText.toUpperCase(),
                      style:
                          AppFonts.font9w600.copyWith(color: AppColors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
