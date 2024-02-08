import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/appBar/sliver_app_bar_delegate.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.height,
    this.color = AppColors.black,
    required this.isBack,
    required this.title,
    this.isSetting = false,
  });

  final double height;
  final Color color;
  final bool isBack;
  final String title;
  final bool isSetting;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: height,
        maxHeight: height,
        child: Container(
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isBack) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    color: AppColors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                      )),
                ),
              ] else ...[
                const SizedBox(
                  height: 24,
                  width: 55,
                )
              ],
              Text(
                title,
                style: AppFonts.font18w500.copyWith(
                  color: AppColors.white,
                ),
              ),
              if (isBack) ...[
                const SizedBox(
                  height: 24,
                  width: 55,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
