import 'package:bcsports_mobile/features/ar/data/unity_scenes.dart';
import 'package:bcsports_mobile/features/market/ui/widgets/nft_user_ar.dart';
import 'package:bcsports_mobile/features/profile/bloc/user_nft/user_nft_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ArPlayersScreen extends StatefulWidget {
  const ArPlayersScreen({super.key});

  @override
  State<ArPlayersScreen> createState() => _MarketLotsScreenState();
}

class _MarketLotsScreenState extends State<ArPlayersScreen> {
  late final ProfileRepository profileRepository;

  @override
  void initState() {
    profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    profileRepository.loadUserNftList();
    super.initState();
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
    final localize = AppLocalizations.of(context)!;

    String text = localize.my_players;

    return BlocBuilder<UserNftCubit, UserNftState>(
      builder: (context, state) {
        if (state is UserNftLoading) {
          return Center(
            child: AppAnimations.circleIndicator,
          );
        } else if (state is UserNftSuccess) {
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
                  sliver: BlocBuilder<UserNftCubit, UserNftState>(
                    builder: (context, state) {
                      if (state is UserNftCubit) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: AppAnimations.circleIndicator,
                          ),
                        );
                      } else if (state is UserNftSuccess) {
                        List<NftModel> nftList = profileRepository.userNftList;

                        if (nftList.isEmpty) {
                          return buildEmptyDataMessage();
                        }

                        return SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 29,
                                  crossAxisSpacing: 8,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.58),
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => NftUserAr(
                                    nft: nftList[index],
                                    onTap: () {
                                      Navigator.pushNamed(context, AppRouteNames.unity, arguments: {'scene': UnityScenes.ar});
                                    },
                                  ),
                              childCount: nftList.length),
                        );
                      }

                      return SliverToBoxAdapter(child: Container());
                    },
                  ))
            ],
          );
        }

        return Container();
      },
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
              localize.you_dont_nfts,
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
