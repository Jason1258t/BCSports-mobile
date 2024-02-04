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
                      children: [
                        Text(
                          "Fincher",
                          style: AppFonts.font12w600
                              .copyWith(color: AppColors.white),
                        ),
                        const Spacer(),
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.black_222232,
                              shape: BoxShape.circle),
                          child: SvgPicture.asset('assets/icons/bell.svg'),
                        ),
                      ],
                    )),

                
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trending Bids 🔥",
                          style: AppFonts.font18w600,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "See more",
                            style: AppFonts.font10w500
                                .copyWith(color: AppColors.yellow_F3D523),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 38),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  sliver: SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 29,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 0.7),
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



// appBar: AppBar(
              // backgroundColor: Colors.transparent,
              // surfaceTintColor: Colors.transparent,
              // elevation: 0,
            //   centerTitle: false,
            //   title: Text("Fincher", style: AppFonts.font12w600.copyWith(color: AppColors.white),),
            // ),


// GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     mainAxisSpacing: 29,
//                     crossAxisSpacing: 8,
//                       crossAxisCount: 2, childAspectRatio: 0.7),
//                   itemBuilder: (context, index) => MarketNftCard(
//                         nft: NftModel.fish,
//                       )),