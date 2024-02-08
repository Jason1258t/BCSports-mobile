import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class WalletToken extends StatelessWidget {
  final String title;
  final String prise;
  final String imageUrl;

  final VoidCallback onTap;

  const WalletToken(
      {super.key,
      required this.title,
      required this.prise,
      required this.onTap,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: 64,
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          // color: AppColors.backgroundSecondary,
                          borderRadius: BorderRadius.circular(32),
                          image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      title,
                      style: AppFonts.font16w400,
                    ),
                  ],
                ),
                Text(prise, style: AppFonts.font16w400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
