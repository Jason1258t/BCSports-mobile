import 'dart:ui';

import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/custon_network_image.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/photo_view.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImagePostBody extends StatefulWidget {
  const ImagePostBody(
      {super.key, required this.post, required this.onDoubleTap});

  final PostViewModel post;
  final VoidCallback onDoubleTap;

  @override
  State<ImagePostBody> createState() => _ImagePostBodyState();
}

class _ImagePostBodyState extends State<ImagePostBody> {
  bool showMore = false;

  int totalTextLength() {
    if ((widget.post.postModel.text ?? '').isEmpty) return 0;

    return '${widget.post.authorName} ${widget.post.postModel.text}'.length;
  }

  bool showHeartAnimation = false;

  double heartScale = 1;
  double heartOpacity = 0;
  Duration heartScaleDuration = const Duration(milliseconds: 500);
  Duration heartOpacityDuration = const Duration(milliseconds: 400);

  void showHeart() async {
    setState(() {
      heartOpacity = heartOpacity == 0 ? 0.8 : 0;
      heartScale = heartScale == 1 ? 4 : 1;
    });
    await Future.delayed(heartScaleDuration);
    setState(() {
      heartOpacity = heartOpacity == 0 ? 0.8 : 0;
      heartScale = heartScale == 1 ? 4 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PhotoViewScreen(url: widget.post.imageUrl!))),
              onDoubleTap: () {
                widget.onDoubleTap();
                showHeart();
              },
              child: CustomNetworkImage(
                color: AppColors.black_s2new_1A1A1A,
                url: widget.post.compressedImageUrl!,
                child: CustomNetworkImage(url: widget.post.imageUrl!),
              ),
            ),
            AnimatedOpacity(
              opacity: heartOpacity,
              duration: heartOpacityDuration,
              curve: Curves.bounceInOut,
              child: AnimatedScale(
                scale: heartScale,
                duration: heartScaleDuration,
                curve: Curves.bounceInOut,
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(Assets.icons('red_heart.svg'))),
              ),
            )
          ],
        ),
        if ((widget.post.postModel.text ?? '').isNotEmpty) ...[
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: widget.post.authorName,
                              style: AppFonts.font14w500),
                          TextSpan(
                              text: '  ${widget.post.postModel.text}',
                              style: AppFonts.font14w300.copyWith(
                                  color: const Color(0xFFEAEAEA), height: 1.2, fontWeight: FontWeight.w100)),
                        ]),
                        maxLines: showMore ? 10 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (totalTextLength() > 80) ...[
                  const SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showMore = !showMore;
                      });
                    },
                    child: Text(
                      !showMore ? localize.more : localize.hide,
                      style: AppFonts.font12w300
                          .copyWith(color: const Color(0xFF717477)),
                    ),
                  )
                ]
              ],
            ),
          )
        ]
      ],
    );
  }
}
