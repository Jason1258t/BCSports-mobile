import 'package:bcsports_mobile/features/market/bloc/buy/buy_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/favourite/favourite_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/nft_details/nft_details_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/sell/sell_cubit.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/ar_button.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/general_statistics.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/market_details_appbar.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_app_stats.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/popups/sell_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MarketProductSellScreen extends StatefulWidget {
  final NftModel nft;

  const MarketProductSellScreen({super.key, required this.nft});

  @override
  State<MarketProductSellScreen> createState() =>
      _MarketProductSellScreenState();
}

class _MarketProductSellScreenState extends State<MarketProductSellScreen> {

  late final NftDetailsCubit nftCubit;
  late final MarketRepository marketRepository;

  @override
  void initState() {
    initProviders();
    nftCubit.getNftDetails(widget.nft);

    super.initState();
  }

  void initProviders() {
    nftCubit = context.read<NftDetailsCubit>();
    marketRepository = context.read<MarketRepository>();
  }

  void onBuyTap() {
    showDialog(
        context: context,
        builder: (context) => SellNftPopup(
              nft: marketRepository.nftService.lastLoadedNft,
            ));
  }

  void onLikeTap(bool isLiked) {
    if (isLiked) {
      context
          .read<FavouriteCubit>()
          .removeFromFavourites(marketRepository.nftService.lastLoadedNft);
    } else {
      context
          .read<FavouriteCubit>()
          .markAsFavourite(marketRepository.nftService.lastLoadedNft);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      child: SafeArea(
        child: BlocBuilder<NftDetailsCubit, NftDetailsState>(
          builder: (context, state) {
            if (state is NftDetailsLoading) {
              return Center(child: AppAnimations.circleIndicator);
            } else if (state is NftDetailsSuccess) {
              return Scaffold(
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTextButton(
                        height: 52,
                        text: "Sell",
                        onTap: onBuyTap,
                        isActive: true),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  backgroundColor: Colors.transparent,
                  body: buildNftCardWidget());
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget buildNftCardWidget() {
    final size = MediaQuery.sizeOf(context);

    return BlocListener<SellCubit, SellState>(
      listener: (context, state) {
        if (state is SellSuccess || state is SellFailure) {
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (state is SellLoading) {
          showDialog(
              context: context,
              builder: (context) =>
                  Center(child: AppAnimations.circleIndicator));
        } else if (state is SellFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar("Smth went wrong!"));
        } else if (state is SellSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar("Success sell!"));
        }
      },
      child: CustomScrollView(
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
                            placeholder: const AssetImage(
                                "assets/images/noname_det.png"),
                            image: NetworkImage(marketRepository
                                .nftService.lastLoadedNft.imagePath)),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: BlocBuilder<FavouriteCubit, FavouriteState>(
                            builder: (context, state) {
                              final user =
                                  context.read<ProfileRepository>().user;
                              final userNfts = user.favouritesNftList;
                              final bool isLiked = userNfts.contains(
                                  marketRepository
                                      .nftService.lastLoadedNft.documentId);

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PlayerAppStatsWidget(
                        value: 0,
                        statsName: "Favorites",
                        iconPath: 'assets/icons/like.svg',
                      ),
                      PlayerAppStatsWidget(
                        value: marketRepository.nftService.lastLoadedNft.views,
                        statsName: "Views",
                        iconPath: 'assets/icons/ar.svg',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  NftArButton(
                    isActive: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
          GeneralStatistics(nft: marketRepository.nftService.lastLoadedNft)
        ],
      ),
    );
  }
}
