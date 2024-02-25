import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/mini_appbar_button.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/nft_card.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late final MarketRepository marketRepository;
  late final ProfileRepository profileRepository;

  @override
  void initState() {
    initProviders();
    super.initState();
  }

  initProviders() {
    marketRepository = RepositoryProvider.of<MarketRepository>(context);
    profileRepository = RepositoryProvider.of<ProfileRepository>(context);
  }

  void onFavouritesTap() {
    Navigator.of(context).pushNamed(AppRouteNames.favourites);
  }

  void onMyLotsTap() {
    Navigator.of(context).pushNamed(AppRouteNames.marketLots);
  }

  void onNftCardTap(MarketItemModel product) {
    Navigator.of(context).pushNamed('/market/buy', arguments: {'nft': product});
  }

  Future<void> updateUser() async {
    await context
        .read<ProfileRepository>()
        .setUser(context.read<AuthRepository>().currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        padding: EdgeInsets.zero,
        color: AppColors.background,
        body: buildMainInfoWidget());
  }

  Widget buildMainInfoWidget() {
    final localize = AppLocalizations.of(context)!;

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await updateUser();
        marketRepository.subscribeOnMarketStream();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
              titleSpacing: 22,
              leadingWidth: 22,
              backgroundColor: AppColors.black,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              floating: true,
              title: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MiniAppBarButton(
                          onTap: onFavouritesTap,
                          iconPath: 'assets/icons/like.svg',
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        MiniAppBarButton(
                          onTap: onMyLotsTap,
                          iconPath: 'assets/icons/lots.svg',
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      localize.all_collection,
                      style: AppFonts.font18w600,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRouteNames.wallet);
                      },
                      borderRadius: BorderRadius.circular(31),
                      child: SvgPicture.asset(
                        'assets/icons/wallet2.svg',
                        width: 24,
                      ),
                    ),
                  ),
                ],
              )),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            sliver: StreamBuilder(
                stream: context.read<MarketRepository>().marketStream,
                builder: (context, snapshot) {
                  List<MarketItemModel> productList = marketRepository
                      .productList
                      .where((product) =>
                          product.lastOwnerId != profileRepository.user.id)
                      .toList();

                  return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 29,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 0.59),
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => MarketNftCard(
                                nft: productList[index].nft,
                                onTap: () {
                                  onNftCardTap(productList[index]);
                                },
                              ),
                          childCount: productList.length));
                }),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 50),
          )
        ],
      ),
    );
  }
}
