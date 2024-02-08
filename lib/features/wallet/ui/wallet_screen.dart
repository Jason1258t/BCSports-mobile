import 'package:bcsports_mobile/features/wallet/ui/widgets/wallet_action_widget.dart';
import 'package:bcsports_mobile/features/wallet/ui/widgets/wallet_token.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/appBar/custom_sliver_app_bar.dart';
import 'package:bcsports_mobile/widgets/appBar/sliver_app_bar_delegate.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return CustomScaffold(
      color: AppColors.black_3A3A3A,
        padding: EdgeInsets.zero,
        body: Container(
          color: AppColors.black,
          child: CustomScrollView(slivers: [
            CustomSliverAppBar(
              height: 90,
              isBack: true,
              title: 'Wallet',
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
                              Text(
                                '100',
                                style: AppFonts.font44w800,
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
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                delegate: SliverChildListDelegate(List.generate(
                    50,
                    (index) => WalletToken(
                          title: 'Ethereum',
                          prise: '100',
                          onTap: () {},
                          imageUrl: 'https://firebasestorage.googleapis.com/v0/b/bcsports-mobile.appspot.com/o/feed_post_images%2F0a4c4440-8b2b-1ea2-8c4a-49bf9e54f2eb.jpeg?alt=media&token=fee3c880-fa19-4d2d-888b-346173f8ccef',
                        ))))
          ]),
        ));
  }
}
