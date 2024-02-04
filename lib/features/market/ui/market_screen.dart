import 'package:bcsports_mobile/features/market/ui/widgets/nft_card.dart';
import 'package:bcsports_mobile/features/profile/widgets/Nft_item.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  String explore = "All Collections";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black_090723,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                    titleSpacing: 22,
                    leadingWidth: 22,
                    backgroundColor: AppColors.black_090723,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    floating: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.black_222232,
                              borderRadius: BorderRadius.circular(31)),
                          child: Row(
       
                            children: [
                              SvgPicture.asset('assets/icons/bankcard.svg'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "1231",
                                style: AppFonts.font14w500
                                    .copyWith(color: AppColors.white),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("ETH",
                                  style: AppFonts.font14w500
                                      .copyWith(color: AppColors.yellow_F3D523))
                            ],
                          ),
                        ),
                      ],
                    )),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      explore,
                      style: AppFonts.font18w600,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  sliver: SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 29,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 0.59),
                      itemBuilder: (context, index) => MarketNftCard(
                            nft: NftModel.fish,
                          )),
                )
              ],
            )),
      ),
    );
  }
}
