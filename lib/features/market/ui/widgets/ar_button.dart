import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/gradients.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:flutter/material.dart';

class NftArButton extends StatelessWidget {
  final bool isActive;

  NftArButton({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
    String arButton = localize.go_ar;

    return CustomTextButton(
      text: arButton, onTap: () {}, isActive: isActive, height: 52,);
  }
}
