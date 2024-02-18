import 'package:bcsports_mobile/features/ar/ui/widgets/ar_banner_widget.dart';
import 'package:bcsports_mobile/features/ar/ui/widgets/medium_activity_widget.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class ArMiniGagesScreen extends StatefulWidget {
  const ArMiniGagesScreen({super.key});

  @override
  State<ArMiniGagesScreen> createState() => _ArMiniGagesScreenState();
}

class _ArMiniGagesScreenState extends State<ArMiniGagesScreen> {
  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
    final sizeOf = MediaQuery.sizeOf(context);

    return CustomScaffold(
        padding: EdgeInsets.all(sizeOf.width * 0.058).copyWith(bottom: 0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              ButtonBack(onTap: () {
                Navigator.pop(context);
              }),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.black_s2new_1A1A1A),
                child: Column(
                  children: [
                    ArBannerWidget(
                      width: sizeOf.width,
                      height: sizeOf.width * 0.456,
                      assetIcon: 'bxs_joystick.svg',
                      title: localize.mini_games,
                      text: localize.choose_play,
                      backGroundImage: 'ar/footboll_field.png',
                    ),
                    Container(
                      padding: EdgeInsets.all(sizeOf.width * 0.037),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              MediumActivityWidget(
                                width: sizeOf.width * 0.3865,
                                assetIcon: 'fluent_run-16-filled.svg',
                                height: sizeOf.width * 0.3865,
                                title: localize.footbag,
                                text: localize.hit_the_max,
                              ),
                              SizedBox(
                                width: sizeOf.width * 0.037,
                              ),
                              MediumActivityWidget(
                                width: sizeOf.width * 0.3865,
                                assetIcon: 'game-icons_feathered-wing.svg',
                                height: sizeOf.width * 0.3865,
                                title: localize.penalties,
                                text: localize.trick_goalkeeper,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: sizeOf.width * 0.037,
                          ),
                          Row(
                            children: [
                              MediumActivityWidget(
                                width: sizeOf.width * 0.3865,
                                assetIcon: 'mdi_basketball.svg',
                                height: sizeOf.width * 0.3865,
                                title: localize.basketball,
                                text: localize.show_aim,
                              ),
                              SizedBox(
                                width: sizeOf.width * 0.037,
                              ),
                              MediumActivityWidget(
                                width: sizeOf.width * 0.3865,
                                assetIcon:
                                    'material-symbols_sports-motorsports-sharp.svg',
                                height: sizeOf.width * 0.3865,
                                title: 'MotoGP',
                                text:
                                    localize.feel_professional,
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
        ));
  }
}
