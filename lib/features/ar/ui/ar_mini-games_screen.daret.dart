import 'package:bcsports_mobile/features/ar/ui/widgets/ar_banner_widget.dart';
import 'package:bcsports_mobile/features/ar/ui/widgets/medium_activity_widget.dart';
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
    final sizeOf = MediaQuery.sizeOf(context);

    return CustomScaffold(
        padding: EdgeInsets.all(sizeOf.width * 0.058),
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
        body: Column(
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
                    title: 'Mini-games',
                    text: 'Выбери, сыгрый, победи',
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
                              title: 'Footbag',
                              text: 'Набей максимальное количество раз',
                            ),
                            SizedBox(
                              width: sizeOf.width * 0.037,
                            ),
                            MediumActivityWidget(
                              width: sizeOf.width * 0.3865,
                              assetIcon: 'fluent_run-16-filled.svg',
                              height: sizeOf.width * 0.3865,
                              title: 'Penalty',
                              text: 'Обхитри вратаря и попади в ворота',
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
                              assetIcon: 'fluent_run-16-filled.svg',
                              height: sizeOf.width * 0.3865,
                              title: 'Basketball',
                              text:
                                  'Покажи свою меткость и точность, забей трехочковый',
                            ),
                            SizedBox(
                              width: sizeOf.width * 0.037,
                            ),
                            MediumActivityWidget(
                              width: sizeOf.width * 0.3865,
                              assetIcon: 'fluent_run-16-filled.svg',
                              height: sizeOf.width * 0.3865,
                              title: 'MotoGP',
                              text: 'Почувствуй себя проффесиональным гонщиком',
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
        ));
  }
}
