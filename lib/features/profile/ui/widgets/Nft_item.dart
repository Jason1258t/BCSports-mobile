import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class NftItemWidget extends StatelessWidget {
  const NftItemWidget({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height * 0.8 - 20,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(11)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Forsy hand',
                style: AppFonts.font14w500,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '1.261 ETH',
                style: AppFonts.font14w500
                    .copyWith(color: AppColors.primary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
