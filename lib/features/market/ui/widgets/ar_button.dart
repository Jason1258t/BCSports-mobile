import 'package:bcsports_mobile/features/ar/data/unity_scenes.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:flutter/material.dart';

class NftArButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;


  const NftArButton({super.key, required this.isActive, required this.onTap});



  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;
    String arButton = localize.go_ar;

    return CustomTextButton(
      text: arButton,
      onTap: onTap,
      isActive: isActive,
      height: 52,
    );
  }
}
