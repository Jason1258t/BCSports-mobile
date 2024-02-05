import 'package:bcsports_mobile/features/market/ui/widgets/player_app_stats.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_details_article.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_details_line.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:flutter/material.dart';


class MarketProductScreen extends StatefulWidget {
  final NftModel nft;

  const MarketProductScreen({super.key, required this.nft});

  @override
  State<MarketProductScreen> createState() => _MarketProductScreenState();
}

class _MarketProductScreenState extends State<MarketProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                sliver: SliverAppBar(
                    floating: true,
                    elevation: 0,
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: AppColors.black,
                    centerTitle: true,
                    leading: ButtonBack(
                      onTap: () => Navigator.pop(context),
                      isDark: false,
                    ),
                    title: Text(
                      "Details",
                      style: AppFonts.font18w500.copyWith(
                        color: AppColors.white,
                      ),
                    )),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 18,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [
                      Image.network(widget.nft.imagePath,
                          width: double.infinity, fit: BoxFit.fitWidth,
                          loadingBuilder: ((context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                            child: CircularProgressIndicator.adaptive());
                      })),
                      const SizedBox(
                        height: 12,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlayerAppStatsWidget(
                            value: 0,
                            statsName: "Favorites",
                            iconPath: 'assets/icons/like.svg',
                          ),
                          PlayerAppStatsWidget(
                            value: 1,
                            statsName: "Owners",
                            iconPath: 'assets/icons/people.svg',
                          ),
                          PlayerAppStatsWidget(
                            value: 1,
                            statsName: "Editions",
                            iconPath: 'assets/icons/edit.svg',
                          ),
                          PlayerAppStatsWidget(
                            value: 12,
                            statsName: "Views",
                            iconPath: 'assets/icons/ar.svg',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextButton(
                          text: "Place a bit", onTap: () {}, isActive: true),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            bottom: 9, top: 12, right: 14, left: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.black_1A1A1A,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Bid",
                                  style: AppFonts.font14w400
                                      .copyWith(color: AppColors.white),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "1.261 ETH",
                                  style: AppFonts.font16w500
                                      .copyWith(color: AppColors.yellow_F3D523),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "4517.2",
                                  textAlign: TextAlign.start,
                                  style: AppFonts.font10w500
                                      .copyWith(color: AppColors.grey_B3B3B3),
                                )
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 8, left: 13, right: 13),
                              decoration: BoxDecoration(
                                  color: AppColors.black_262627,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Ending in",
                                      style: AppFonts.font16w500.copyWith(
                                          color: AppColors.yellow_F3D523)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "26 days",
                                        style: AppFonts.font12w400
                                            .copyWith(color: AppColors.white),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 12,
                                        color: AppColors.black,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                      ),
                                      Text(
                                        "26 days",
                                        style: AppFonts.font12w400
                                            .copyWith(color: AppColors.white),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 12,
                                        color: AppColors.black,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                      ),
                                      Text(
                                        "26 days",
                                        style: AppFonts.font12w400
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 28,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    color: AppColors.black_1A1A1A,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22)
                      .copyWith(top: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: AppFonts.font24w600
                            .copyWith(color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const PlayerDetailsArticleWidget(
                        title: "About player",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Fast player with good dribbling and passing. Looks good in attack but has some work to do in defence.",
                        style: AppFonts.font12w400
                            .copyWith(color: AppColors.grey_B3B3B3),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const PlayerDetailsArticleWidget(
                        title: "Player detailis",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PlayerDetailsLineWidget(
                        attr: "Name",
                        value: widget.nft.name,
                      ),
                      PlayerDetailsLineWidget(
                        attr: "Date of birth",
                        value: widget.nft.birthday.toString(),
                      ),
                      PlayerDetailsLineWidget(
                        attr: "Club name",
                        value: widget.nft.club,
                      ),
                      PlayerDetailsLineWidget(
                        attr: "Citizenship",
                        value: widget.nft.citizenship,
                      ),
                      PlayerDetailsLineWidget(
                        attr: "Height",
                        value: widget.nft.height.toString(),
                      ),
                      PlayerDetailsLineWidget(
                        attr: "Position",
                        value: widget.nft.position,
                      ),
                      PlayerDetailsLineWidget(
                        attr: "Weight",
                        value: widget.nft.weight.toString(),
                      ),
                      PlayerDetailsLineWidget(
                        attr: "Foot",
                        value:
                            widget.nft.isRightFoot ? "Right foot" : "Left foot",
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      // const PlayerDetailsArticleWidget(
                      //   title: "Statistic",
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
