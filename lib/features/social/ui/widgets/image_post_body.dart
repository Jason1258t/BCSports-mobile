import 'dart:developer';
import 'dart:ui';

import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/custon_network_image.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/photo_view.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';

class ImagePostBody extends StatefulWidget {
  const ImagePostBody({super.key, required this.post});

  final PostViewModel post;

  @override
  State<ImagePostBody> createState() => _ImagePostBodyState();
}

class _ImagePostBodyState extends State<ImagePostBody> {
  bool showMore = false;

  int totalTextLength() {
    if ((widget.post.postModel.text ?? '').isEmpty) return 0;

    return '${widget.post.authorName} ${widget.post.postModel.text}'.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PhotoViewScreen(url: widget.post.imageUrl!))),
          child: CustomNetworkImage(
            url: widget.post.compressedImageUrl!,
            child: CustomNetworkImage(url: widget.post.imageUrl!),
          ),
        ),
        if ((widget.post.postModel.text ?? '').isNotEmpty) ...[
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: widget.post.authorName,
                          style: AppFonts.font12w600),
                      TextSpan(
                          text: ' ${widget.post.postModel.text}',
                          style: AppFonts.font12w300.copyWith(
                              color: const Color(0xFFEBEAEC), height: 1.2)),
                    ]),
                    maxLines: showMore ? 10 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (totalTextLength() > 60) ...[
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showMore = !showMore;
                      });
                    },
                    child: Text(
                      !showMore ? 'more' : 'hide',
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
