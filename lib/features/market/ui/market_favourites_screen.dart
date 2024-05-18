import 'package:bcsports_mobile/features/market/bloc/favourite/favourite_cubit.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/nft_card.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/utils/utils.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MarketFavouritesScreen extends StatefulWidget {
  const MarketFavouritesScreen({super.key});

  @override
  State<MarketFavouritesScreen> createState() => _MarketFavouritesScreenState();
}

class _MarketFavouritesScreenState extends State<MarketFavouritesScreen> {
  void onNftCardTap(MarketItemModel product) {
    Navigator.of(context).pushNamed('/market/buy', arguments: {'nft': product});
  }

  List<MarketItemModel> getFavouritesNftList() {
    return context.read<FavouriteCubit>().getFavouritesUserList();
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return Container(
      color: AppColors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: buildMainInfoWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              final favouritesList = getFavouritesNftList();
              if (favouritesList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomTextButton(
                    isActive: true,
                    onTap: () => Navigator.pop(context),
                    text: localize.add_nft,
                    height: 52,
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildMainInfoWidget() {
    final localize = AppLocalizations.of(context)!;
    String text = localize.favs;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
            backgroundColor: AppColors.black,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            floating: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ButtonBack(
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  text,
                  style: AppFonts.font18w600,
                ),
              ],
            )),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            sliver: BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
                final favouriteNftList = getFavouritesNftList();

                if (favouriteNftList.isEmpty) {
                  return buildEmptyDataMessage();
                }

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 29,
                      crossAxisSpacing: 8,
                      crossAxisCount: 2,
                      childAspectRatio: 0.59),
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => MarketNftCard(
                            nft: favouriteNftList[index].nft,
                            onTap: () {
                              onNftCardTap(favouriteNftList[index]);
                            },
                          ),
                      childCount: favouriteNftList.length),
                );
              },
            ))
      ],
    );
  }

  Widget buildEmptyDataMessage() {
    final localize = AppLocalizations.of(context)!;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height - 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              "assets/icons/poop.svg",
              color: AppColors.grey_B4B4B4,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              localize.no_favs,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.font16w300
                  .copyWith(color: AppColors.grey_B4B4B4, height: 1.2),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
