import 'package:bcsports_mobile/features/ar/data/scene_data.dart';
import 'package:bcsports_mobile/features/ar/data/unity_scenes.dart';
import 'package:bcsports_mobile/features/ar/ui/widgets/ar_banner_widget.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final localize = AppLocalizations.of(context)!;

    return CustomScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.black,
          surfaceTintColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                localize.ar,
                style: AppFonts.font18w600,
              ),
            ],
          ),
        ),
        padding:
            EdgeInsets.all(sizeOf.width * 0.058).copyWith(bottom: 0, top: 0),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ArBannerWidget(
                width: sizeOf.width,
                height: sizeOf.width * 0.456,
                assetIcon: 'people_with_rows.svg',
                title: localize.player,
                text: localize.make_selfie,
                backGroundImage: 'ar/ar_pepole.png',
                onTap: () {
                  Navigator.pushNamed(context, AppRouteNames.arUserNft);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ArBannerWidget(
                width: sizeOf.width,
                height: sizeOf.width * 0.456,
                assetIcon: 'game-icons_soccer-ball.svg',
                title: localize.academy,
                text: localize.ar_visual,
                backGroundImage: 'ar/dybai.png',
                onTap: () {
                  Navigator.pushNamed(context, AppRouteNames.unity,
                      arguments: SceneData(
                          sceneId: UnityScenes.stadium, title: localize.academy));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ArBannerWidget(
                width: sizeOf.width,
                height: sizeOf.width * 0.456,
                assetIcon: 'bxs_joystick.svg',
                title: localize.mini_games,
                text: localize.choose_play,
                backGroundImage: 'ar/footboll_field.png',
                onTap: () {
                  Navigator.pushNamed(context, AppRouteNames.unity,
                      arguments: SceneData(
                          sceneId: UnityScenes.menu,
                          title: localize.mini_games));
                },
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}
