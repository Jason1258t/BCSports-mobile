import 'package:bcsports_mobile/features/market/bloc/buy/buy_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/favourite/favourite_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/favourites_value/favourites_value_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/nft_details/nft_details_cubit.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/ar_button.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/general_statistics.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/market_details_appbar.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/player_app_stats.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/popups/buy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../ar/data/scene_data.dart';
import '../../ar/data/unity_scenes.dart';

class MarketProductBuyScreen extends StatefulWidget {
  final MarketItemModel product;

  const MarketProductBuyScreen({super.key, required this.product});

  @override
  State<MarketProductBuyScreen> createState() => _MarketProductBuyScreenState();
}

class _MarketProductBuyScreenState extends State<MarketProductBuyScreen> {
  late final NftDetailsCubit nftCubit;
  late final MarketRepository marketRepository;

  @override
  void initState() {
    initProviders();

    nftCubit.getNftDetails(widget.product.nft);
    marketRepository.getLotFavouritesValue(widget.product.id);

    super.initState();
  }

  void initProviders() {
    nftCubit = context.read<NftDetailsCubit>();
    marketRepository = context.read<MarketRepository>();
  }

  void onBuyTap() {
    showDialog(
        context: context,
        builder: (context) => BuyNftPopup(
              product: widget.product,
            ));
  }

  void onLikeTap(bool isLiked) {
    if (isLiked) {
      context.read<FavouriteCubit>().removeFromFavourites(widget.product);
      context.read<FavouritesValueCubit>().decrementFavouriteValue();
    } else {
      context.read<FavouriteCubit>().markAsFavourite(widget.product);
      context.read<FavouritesValueCubit>().incrementFavouriteValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return BlocConsumer<BuyNftCubit, BuyNftState>(
      listener: (context, state) {
        if (state is BuyNftSuccess || state is BuyNftFail) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (state is BuyNftLoading) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) =>
                  Center(child: AppAnimations.circleIndicator));
        } else if (state is BuyNftFail) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar("Smth went wrong!"));
        } else if (state is BuyNftSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar(localize.success_buy));
        }
      },
      builder: (context, state) => Container(
        color: AppColors.black,
        child: SafeArea(
          child: BlocBuilder<NftDetailsCubit, NftDetailsState>(
            builder: (context, state) {
              if (state is NftDetailsLoading) {
                return Center(child: AppAnimations.circleIndicator);
              } else if (state is NftDetailsSuccess) {
                return Scaffold(
                    floatingActionButton: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CustomTextButton(
                        text: localize.buy,
                        onTap: onBuyTap,
                        isActive: true,
                        height: 52,
                      ),
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
      ),
    );
  }

  Widget buildNftCardWidget() {
    final size = MediaQuery.sizeOf(context);
    final nft = marketRepository.nftService.lastLoadedNft;
    final localize = AppLocalizations.of(context)!;

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
                          image: NetworkImage(nft.imagePath)),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: BlocBuilder<FavouriteCubit, FavouriteState>(
                          builder: (context, state) {
                            final user = context.read<ProfileRepository>().user;
                            final userNfts = user.favouritesNftList;
                            final bool isLiked =
                                userNfts.contains(widget.product.id);

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
                    BlocBuilder<FavouritesValueCubit, FavouritesValueState>(
                      builder: (context, state) {
                        return PlayerAppStatsWidget(
                          value: marketRepository.lastProductFavouritesValue
                              .toString(),
                          statsName: localize.favourite,
                          iconPath: 'assets/icons/like.svg',
                        );
                      },
                    ),
                    PlayerAppStatsWidget(
                      value: nft.views.toString(),
                      statsName: localize.views,
                      iconPath: 'assets/icons/ar.svg',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                NftArButton(
                  isActive: false,
                  onTap: () {
                    final id = nft.documentId;

                    if (['k1OMkMhk5WdlcNYKXT6z', 'y6vbrSUxlPe1iBGVJlac']
                        .contains(id)) {
                      Navigator.pushNamed(context, AppRouteNames.unity,
                          arguments: SceneData(
                              sceneId: id == 'k1OMkMhk5WdlcNYKXT6z'
                                  ? UnityScenes.k1OMkMhk5WdlcNYKXT6z
                                  : UnityScenes.y6vbrSUxlPe1iBGVJlac,
                              title: 'Player'));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackBars.snackBar(
                              'Sorry this player haven\'t ar yet'));
                    }
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
        GeneralStatistics(nft: nft)
      ],
    );
  }
}
