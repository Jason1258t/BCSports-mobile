import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_avatar.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/time_difference.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

class FeedPostWidget extends StatelessWidget {
  const FeedPostWidget({super.key, required this.post, required this.user});

  final PostModel post;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
          child: Row(
            children: [
              SmallAvatarWidget(user: user),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    user.displayName ?? user.username,
                    style: AppFonts.font14w400
                        .copyWith(color: AppColors.white_F4F4F4),
                  )),
                  Text(
                    DateTimeDifferenceConverter.diffToString(post.createdAt),
                    style: AppFonts.font12w400
                        .copyWith(color: const Color(0xFF717477)),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        if (post.text != null) ...[
          Text(
            post.text!,
            style: AppFonts.font16w400.copyWith(color: AppColors.white_F4F4F4),
          )
        ],
        if (post.imageUrl != null && post.text != null) ...[
          const SizedBox(
            height: 16,
          ),
        ],
        if (post.imageUrl != null) ...[
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PhotoViewScreen(url: post.imageUrl!))),
            child: CustomNetworkImage(
              url: post.compressedImageUrl!,
              child: CustomNetworkImage(url: post.imageUrl!),
            ),
          )
        ],
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            SvgPicture.asset(
              Assets.icons('heart.svg'),
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              post.likesCount.toString(),
              style: AppFonts.font12w400,
            ),
            const SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              Assets.icons('comment.svg'),
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              post.commentsCount.toString(),
              style: AppFonts.font12w400,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: double.infinity,
          height: 2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppColors.grey_393939),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.url, this.child});

  final String url;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 48,
      height: MediaQuery.sizeOf(context).width / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
      child: child,
    );
  }
}

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: ButtonBack(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: PhotoView(
          maxScale: 0.4,
          minScale: PhotoViewComputedScale.contained,
          backgroundDecoration:
              BoxDecoration(color: AppColors.background.withOpacity(0.4)),
          imageProvider: NetworkImage(url),
        ));
  }
}
