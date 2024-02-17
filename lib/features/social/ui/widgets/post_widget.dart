import 'dart:developer';
import 'dart:ui';

import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/like/like_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/post_comments/post_comments_cubit.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/features/social/ui/comments_screen.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/custon_network_image.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/image_post_body.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/photo_view.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_avatar.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/text_post_body.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
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

enum PostType { withImage, text }

class FeedPostWidget extends StatefulWidget {
  const FeedPostWidget({
    super.key,
    required this.postId,
    required this.source,
    this.commentsActive = true,
    this.userId,
  });

  final String postId;
  final PostSource source;
  final bool commentsActive;
  final String? userId;

  @override
  State<FeedPostWidget> createState() => _FeedPostWidgetState();
}

class _FeedPostWidgetState extends State<FeedPostWidget> {
  bool needUpdate = false;

  @override
  void initState() {
    subscribeChanges();
    super.initState();
  }

  void onLikeTapped() async {
    final bloc = context.read<LikeCubit>();
    final post = widget.source.getCachedPost(widget.postId)!;

    bool like = post.postModel.like;
    bloc.changePostLiked(
        post.postModel.id, !post.postModel.like, widget.source);
    setState(() {});

    if (like) {
      await bloc.unlikePost(post.postModel.id, widget.source);
    } else {
      await bloc.likePost(post.postModel.id, widget.source);
    }
    setState(() {});
  }

  void subscribeChanges() async {
    widget.source.likeChanges.stream.listen((event) async {
      if (event.postId == widget.postId) {
        needUpdate = true;
        try {
          setState(() {});
        } catch (e) {
          log('setState error');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.source.getCachedPost(widget.postId)!;
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);

    final postType =
        post.postModel.imageUrl != null ? PostType.withImage : PostType.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 32,
            child: InkWell(
              onTap: () {
                if (widget.userId != profileRepository.user.id &&
                    widget.userId != null) {
                  context.read<ProfileViewRepository>().setUser(widget.userId!);
                  Navigator.pushNamed(context, AppRouteNames.profileView);
                } else if (widget.userId == profileRepository.user.id) {
                  context.read<MainCubit>().changePageIndexTo(3);
                }
              },
              child: Row(
                children: [
                  SmallAvatarWidget(user: post.user),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        post.user.displayName ?? post.user.username,
                        style: AppFonts.font14w400
                            .copyWith(color: AppColors.white_F4F4F4),
                      )),
                      Text(
                        DateTimeDifferenceConverter.diffToString(
                            post.postModel.createdAt),
                        style: AppFonts.font12w400
                            .copyWith(color: const Color(0xFF717477)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        postType == PostType.text
            ? TextPostBody(text: post.postModel.text!)
            : ImagePostBody(post: post),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(100),
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
                post.postModel.likesCount.toString(),
                style: AppFonts.font12w400,
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  if (widget.commentsActive) {
                    context
                        .read<PostCommentsCubit>()
                        .setPost(post, widget.source);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CommentsScreen()));
                  }
                },
                child: SvgPicture.asset(
                  Assets.icons('comment.svg'),
                  width: 16,
                  height: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                post.postModel.commentsCount.toString(),
                style: AppFonts.font12w400,
              ),
            ],
          ),
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
