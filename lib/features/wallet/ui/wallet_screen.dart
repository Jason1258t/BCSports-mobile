import 'package:bcsports_mobile/features/profile/bloc/user/user_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/wallet/ui/widgets/wallet_action_widget.dart';
import 'package:bcsports_mobile/features/wallet/ui/widgets/wallet_token.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/appBar/custom_sliver_app_bar.dart';
import 'package:bcsports_mobile/widgets/appBar/sliver_app_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final repository = RepositoryProvider.of<ProfileRepository>(context);

    final localize = AppLocalizations.of(context)!;

    return Container(
      color: AppColors.black_3A3A3A,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            backgroundColor: AppColors.black_3A3A3A,
            body: Container(
              color: AppColors.black,
              child: CustomScrollView(slivers: [
                CustomSliverAppBar(
                  height: 90,
                  isBack: true,
                  title: localize.wallet, 
                  isSetting: true,
                  color: AppColors.black_3A3A3A,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: SliverAppBarDelegate(
                    minHeight: 64,
                    maxHeight: 64,
                    child: Container(
                      color: AppColors.black_3A3A3A,
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BlocBuilder<UserCubit, UserState>(
                                    builder: (context, state) {
                                      if (state is UserSuccessState) {
                                        return Text(
                                          '${repository.user.evmBill} ETH',
                                          style: AppFonts.font36w800,
                                        );
                                      } else {
                                        return AppAnimations.circleIndicator;
                                      }
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: sizeOf.width * 0.156 + 40,
                    maxHeight: sizeOf.width * 0.156 + 40,
                    child: Container(
                      color: AppColors.black_3A3A3A,
                      alignment: Alignment.center,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WalletAction(
                              title: 'Send',
                              icon: 'assets/icons/send.svg',
                              onTap: () {},
                            ),
                            WalletAction(
                              title: 'Replanish',
                              icon: 'assets/icons/get.svg',
                              onTap: () {},
                            ),
                            WalletAction(
                              title: 'Swap',
                              icon: 'assets/icons/transfer_arrows_bold.svg',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: SliverAppBarDelegate(
                    minHeight: 17,
                    maxHeight: 17,
                    child: Container(
                      height: 18,
                      decoration: BoxDecoration(
                          color: AppColors.black_3A3A3A,
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16))),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  WalletToken(
                    title: 'Ethereum',
                    prise: repository.user.evmBill.toString(),
                    onTap: () {},
                    imageUrl: 'assets/images/ethereum_image.png',
                  ),
                  WalletToken(
                    title: 'BNB',
                    prise: '100.0',
                    onTap: () {},
                    imageUrl: 'assets/images/bnb_image.png',
                  )
                ]))
              ]),
            )),
      ),
    );
  }
}
