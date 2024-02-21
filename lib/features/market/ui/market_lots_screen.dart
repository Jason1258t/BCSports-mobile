import 'package:bcsports_mobile/features/market/bloc/cansel_lot/cansel_lot_cubit.dart';
import 'package:bcsports_mobile/features/market/bloc/lots/lots_cubit.dart';
import 'package:bcsports_mobile/features/market/data/market_repository.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/nft_user_lot.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/popups/cansel_lot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MarketLotsScreen extends StatefulWidget {
  const MarketLotsScreen({super.key});

  @override
  State<MarketLotsScreen> createState() => _MarketLotsScreenState();
}

class _MarketLotsScreenState extends State<MarketLotsScreen> {
  late final MarketRepository marketRepository;

  @override
  void initState() {
    marketRepository = RepositoryProvider.of<MarketRepository>(context);
    context.read<MarketRepository>().getUserLots();
    super.initState();
  }

  void onCanselActiveLot(MarketItemModel product) {
    showDialog(
        context: context,
        builder: (context) => CanselLotPopup(onAccept: () {
              context.read<CanselLotCubit>().canselLot(product);
              Navigator.pop(context);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CanselLotCubit, CanselLotState>(
      listener: (context, state) {
        if (state is CanselLotFailure || state is CanselLotSuccess) {
          Navigator.pop(context);
        }

        if (state is CanselLotLoading) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) =>
                  Center(child: AppAnimations.circleIndicator));
        } else if (state is CanselLotFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(AppSnackBars.snackBar("Sth went wrong!"));
        }
      },
      child: Container(
        color: AppColors.black,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: buildMainInfoWidget(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: BlocBuilder<LotsCubit, LotsState>(
              builder: (context, state) {
                List<MarketItemModel> lotsList = marketRepository.lotsList;

                if (lotsList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTextButton(
                      isActive: true,
                      onTap: () => Navigator.pop(context),
                      text: "Add NFT",
                      height: 52,
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMainInfoWidget() {
    final localize = AppLocalizations.of(context)!;
    String text = localize.my_active_lots;

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
            sliver: BlocBuilder<LotsCubit, LotsState>(
              builder: (context, state) {
                if (state is LotsLoading) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: AppAnimations.circleIndicator,
                    ),
                  );
                } else if (state is LotsSuccess) {
                  List<MarketItemModel> lotsList = marketRepository.lotsList;

                  if (lotsList.isEmpty) {
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
                              localize.no_lots,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.font16w300.copyWith(
                                  color: AppColors.grey_B4B4B4, height: 1.2),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 29,
                            crossAxisSpacing: 8,
                            crossAxisCount: 2,
                            childAspectRatio: 0.58),
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => NftUserLot(
                              product: lotsList[index],
                              onTap: () {
                                onCanselActiveLot(lotsList[index]);
                              },
                            ),
                        childCount: lotsList.length),
                  );
                }

                return SliverToBoxAdapter(child: Container());
              },
            ))
      ],
    );
  }
}
