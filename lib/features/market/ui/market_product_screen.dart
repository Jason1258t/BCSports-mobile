import 'package:bcsports_mobile/features/market/bloc/favourite/favourite_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/nft_details/nft_details_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/place_bid/place_bid_cubit.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/general_statistics.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/market_details_appbar.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_app_stats.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/popups/place_bit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MarketProductScreen extends StatefulWidget {
  final NftModel nft;

  const MarketProductScreen({super.key, required this.nft});

  @override
  State<MarketProductScreen> createState() => _MarketProductScreenState();
}

class _MarketProductScreenState extends State<MarketProductScreen> {
  Duration remainingTime = Duration.zero;
  late final NftDetailsCubit nftCubit;
  late final MarketRepository marketRepository;

  @override
  void initState() {
    initProviders();
    nftCubit.getNftDetails(widget.nft);

    updateRemainingTime();
    super.initState();
  }

  void initProviders() {
    nftCubit = context.read<NftDetailsCubit>();
    marketRepository = context.read<MarketRepository>();
  }

  void updateRemainingTime() async {
    while (true) {
      remainingTime = widget.nft.auctionStopTime.difference(DateTime.now());
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        setState(() {});
      }
    }
  }

  void onBetTap() {
    showDialog(
        context: context,
        builder: (context) => PlaceBitPopup(
              nft: marketRepository.lastOpenedNft,
            ));
  }

  void onLikeTap(bool isLiked) {
    if (isLiked) {
      context
          .read<FavouriteCubit>()
          .removeFromFavourites(marketRepository.lastOpenedNft);
    } else {
      context
          .read<FavouriteCubit>()
          .markAsFavourite(marketRepository.lastOpenedNft);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaceBidCubit, PlaceBidState>(
      listener: (context, state) {
        if (state is PlaceBidSuccess || state is PlaceBidFail) {
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (state is PlaceBidLoading) {
          showDialog(
              context: context,
              builder: (context) =>
                  Center(child: AppAnimations.circleIndicator));
        } else if (state is PlaceBidFail) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar("Smth went wrong!"));
        } else if (state is PlaceBidSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar("Success bid!"));
        }
      },
      builder: (context, state) => Container(
        color: AppColors.black,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: BlocBuilder<NftDetailsCubit, NftDetailsState>(
                builder: (context, state) {
                  if (state is NftDetailsLoading) {
                    return AppAnimations.circleIndicator;
                  } else if (state is NftDetailsSuccess) {
                    return buildNftCardWidget();
                  }

                  return Container();
                },
              )),
        ),
      ),
    );
  }

  Widget buildNftCardWidget() {
    final size = MediaQuery.sizeOf(context);

    return CustomScrollView(
      slivers: [
        const MarketDetailsAppBar(),
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
                SizedBox(
                  height: (size.width - 40) / 0.96,
                  child: Stack(
                    children: [
                      FadeInImage(
                          fit: BoxFit.fitHeight,
                          placeholder:
                              const AssetImage("assets/images/noname_det.png"),
                          image: NetworkImage(
                              marketRepository.lastOpenedNft.imagePath)),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: BlocBuilder<FavouriteCubit, FavouriteState>(
                          builder: (context, state) {
                            final user = context.read<ProfileRepository>().user;
                            final userNfts = user.favouritesNftList;
                            final bool isLiked = userNfts.contains(
                                marketRepository.lastOpenedNft.documentId);

                            if (state is FavouriteLoading) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: AppAnimations.circleIndicator,
                              );
                            }

                            return InkWell(
                              onTap: () => onLikeTap(isLiked),
                              borderRadius: BorderRadius.circular(10000),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  "assets/icons/${isLiked ? "filled_like" : 'like'}.svg",
                                  color: AppColors.primary,
                                  width: 20,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                    text: "Place a bit", onTap: onBetTap, isActive: true),
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
                            "${marketRepository.lastOpenedNft.currentBit} ETH",
                            style: AppFonts.font16w500
                                .copyWith(color: AppColors.yellow_F3D523),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            widget.nft.lastBidderName.length != ""
                                ? "${marketRepository.lastOpenedNft.lastBidderName.substring(0, 2)}****${marketRepository.lastOpenedNft.lastBidderName.substring(marketRepository.lastOpenedNft.lastBidderName.length - 3, marketRepository.lastOpenedNft.lastBidderName.length)}"
                                : "Noname",
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
                                style: AppFonts.font16w500
                                    .copyWith(color: AppColors.yellow_F3D523)),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${remainingTime.inDays} days",
                                  style: AppFonts.font12w400
                                      .copyWith(color: AppColors.white),
                                ),
                                Container(
                                  width: 1,
                                  height: 12,
                                  color: AppColors.black,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                ),
                                Text(
                                  "${remainingTime.inHours % 24} Hours",
                                  style: AppFonts.font12w400
                                      .copyWith(color: AppColors.white),
                                ),
                                Container(
                                  width: 1,
                                  height: 12,
                                  color: AppColors.black,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                ),
                                Text(
                                  "${remainingTime.inMinutes % 60} Mins",
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
        GeneralStatistics(nft: marketRepository.lastOpenedNft)
      ],
    );
  }
}
