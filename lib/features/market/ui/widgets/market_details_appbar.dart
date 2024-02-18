import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarketDetailsAppBar extends StatelessWidget {
  const MarketDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return SliverAppBar(
        backgroundColor: AppColors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        floating: true,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonBack(
                onTap: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Text(
                localize.details,
                style: AppFonts.font18w500.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
