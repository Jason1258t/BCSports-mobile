import 'package:bcsports_mobile/features/auth/data/auth_repository.dart';
import 'package:bcsports_mobile/features/market/bloc/place_bid/place_bid_cubit.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/nft_card.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  String explore = "All Collections";
  late final MarketRepository marketRepository;

  @override
  void initState() {
    initProviders();

    super.initState();
  }

  initProviders() {
    marketRepository = RepositoryProvider.of<MarketRepository>(context);
  }

  void onFavouritesTap() {
    Navigator.of(context).pushNamed(AppRouteNames.favourites);
  }

  void onNftCardTap(NftModel nft) {
    Navigator.of(context).pushNamed('/market/buy', arguments: {'nft': nft});
  }

  Future<void> updateUser() async {
    await context
        .read<ProfileRepository>()
        .setUser(context.read<AuthRepository>().currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent, body: buildMainInfoWidget()),
      ),
    );
  }

  Widget buildMainInfoWidget() {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await updateUser();
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onFavouritesTap,
                    borderRadius: BorderRadius.circular(10000),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/icons/like.svg",
                        width: 20,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouteNames.wallet);
                    },
                    borderRadius: BorderRadius.circular(31),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.black_s2new_1A1A1A,
                          borderRadius: BorderRadius.circular(31)),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/bankcard.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          BlocBuilder<BuyNftCubit, BuyNftState>(
                            builder: (context, state) {
                              return Text(
                                context
                                    .read<ProfileRepository>()
                                    .user
                                    .evmBill
                                    .toString(),
                                style: AppFonts.font14w500
                                    .copyWith(color: AppColors.white),
                              );
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("ETH",
                              style: AppFonts.font14w500
                                  .copyWith(color: AppColors.primary))
                        ],
                      ),
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
            sliver: StreamBuilder(
                stream: context.read<MarketRepository>().marketStream,
                builder: (context, snapshot) {
                  return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 29,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                              childAspectRatio: 0.59),
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => MarketNftCard(
                                nft: marketRepository.productList[index].nft,
                                onTap: () {
                                  onNftCardTap(
                                      marketRepository.productList[index].nft);
                                },
                              ),
                          childCount: marketRepository.productList.length));
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
