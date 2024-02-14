import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MiniAppBarButton extends StatefulWidget {
  final String iconPath;
  final Function onTap;

  const MiniAppBarButton(
      {super.key, required this.iconPath, required this.onTap});

  @override
  State<MiniAppBarButton> createState() => _MiniAppBarButtonState();
}

class _MiniAppBarButtonState extends State<MiniAppBarButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: AppColors.black_s2new_1A1A1A,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          widget.onTap();
        },
        child: Container(
          alignment: Alignment.center,
          width: 52,
          height: 28,
          child: SvgPicture.asset(
            widget.iconPath,
            width: 19,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}