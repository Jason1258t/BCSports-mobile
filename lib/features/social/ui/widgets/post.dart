import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/home/home_social_cubit.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_avatar.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/time_difference.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

class FeedPostWidget extends StatefulWidget {
  const FeedPostWidget({super.key, required this.post, required this.user});

  final PostModel post;
  final UserModel user;

  @override
  State<FeedPostWidget> createState() => _FeedPostWidgetState();
}

class _FeedPostWidgetState extends State<FeedPostWidget> {
  void onLikeTapped() async {
    final bloc = context.read<HomeSocialCubit>();
    // widget.post.setLike(!widget.post.like);
    bool like = widget.post.like;
    bloc.changePostLiked(widget.post.id, !widget.post.like);
    setState(() {});

    if (like) {
      await bloc.unlikePost(widget.post.id);
    } else {
      await bloc.likePost(widget.post.id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<SocialRepository>();
    final post = repository.getCachedPost(widget.post.id)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
          child: Row(
            children: [
              SmallAvatarWidget(user: widget.user),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    widget.user.displayName ?? widget.user.username,
                    style: AppFonts.font14w400
                        .copyWith(color: AppColors.white_F4F4F4),
                  )),
                  Text(
                    DateTimeDifferenceConverter.diffToString(
                        widget.post.createdAt),
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
        if (widget.post.text != null) ...[
          Text(
            widget.post.text!,
            style: AppFonts.font16w400.copyWith(color: AppColors.white_F4F4F4),
          )
        ],
        if (widget.post.imageUrl != null && widget.post.text != null) ...[
          const SizedBox(
            height: 16,
          ),
        ],
        if (widget.post.imageUrl != null) ...[
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
          )
        ],
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            InkWell(
              onTap: onLikeTapped,
              child: SvgPicture.asset(
                Assets.icons(
                    post.postModel.like ? 'red_heart.svg' : 'heart.svg'),
                width: 16,
                height: 16,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.post.likesCount.toString(),
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
              widget.post.commentsCount.toString(),
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
          imageProvider: NetworkImage(url),
        ));
  }
}
