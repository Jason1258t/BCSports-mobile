import 'package:bcsports_mobile/features/ar/ui/widgets/ar_banner_widget.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return CustomScaffold(
        padding: EdgeInsets.all(sizeOf.width * 0.058).copyWith(bottom: 0),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ArBannerWidget(
                width: sizeOf.width,
                height: sizeOf.width * 0.456,
                assetIcon: 'people_with_rows.svg',
                title: 'Player',
                text:
                    'Сделай селфи или видео с любимым спортсменом,  с помощью AR',
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
                title: 'Academy',
                text: 'AR визуализация Бразильской академии',
                backGroundImage: 'ar/dybai.png',
              ),
              const SizedBox(
                height: 15,
              ),
              ArBannerWidget(
                width: sizeOf.width,
                height: sizeOf.width * 0.456,
                assetIcon: 'bxs_joystick.svg',
                title: 'Mini-games',
                text: 'Выбери, сыгрый, победи',
                backGroundImage: 'ar/footboll_field.png',
                onTap: () {
                  Navigator.pushNamed(context, AppRouteNames.arMiniGames);
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
