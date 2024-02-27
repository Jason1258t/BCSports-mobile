import 'dart:developer';
import 'dart:ui';

import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/delete_post/delete_post_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/like/like_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/post_comments/post_comments_cubit.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/features/social/ui/comments_screen.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/image_post_body.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_actions_bottom_sheet.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/report_modal_bottom_sheet.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_avatar.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/text_post_body.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/time_difference.dart';
import 'package:bcsports_mobile/widgets/dialogs_and_snackbars/error_snackbar.dart';
import 'package:bcsports_mobile/widgets/modal_bottom_sheets/app_modal_bottom_sheets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum PostType { withImage, text }

class FeedPostWidget extends StatefulWidget {
  const FeedPostWidget({
    super.key,
    required this.postId,
    required this.source,
    this.commentsActive = true,
    this.actionsAllowed = true,
  });

  final String postId;
  final PostSource source;
  final bool commentsActive;
  final bool actionsAllowed;

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

  void viewCreator(String userId) {
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);

    if (userId != profileRepository.user.id) {
      context.read<ProfileViewRepository>().setUser(userId);
      Navigator.pushNamed(context, AppRouteNames.profileView);
    } else if (userId == profileRepository.user.id) {
      context.read<MainCubit>().changePageIndexTo(4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.source.getCachedPost(widget.postId)!;
    final postType =
        post.postModel.imageUrl != null ? PostType.withImage : PostType.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: buildPostHeader(post),
        ),
        const SizedBox(
          height: 16,
        ),
        postType == PostType.text
            ? TextPostBody(text: post.postModel.text!)
            : ImagePostBody(
                post: post,
                onDoubleTap: onLikeTapped,
              ),
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset(
                        Assets.icons(post.postModel.like
                            ? 'red_heart.svg'
                            : 'heart.svg'),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      post.postModel.likesCount.toString(),
                      style: AppFonts.font12w400,
                    ),
                  ],
                ),
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
                        CupertinoPageRoute(builder: (_) => CommentsScreen()));
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Assets.icons('comment.svg'),
                      width: 20,
                      height: 20,
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

  Widget buildPostHeader(PostViewModel post) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          InkWell(
            onTap: () => viewCreator(post.user.id),
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
                      post.authorName,
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
                ),
              ],
            ),
          ),
          const Spacer(),
          if (widget.actionsAllowed) ...[
            BlocListener<DeletePostCubit, DeletePostState>(
              listener: (context, state) =>
                  deleteListener(context, state, post),
              child: InkWell(
                  onTap: () => showPostActions(post),
                  child: SizedBox(
                    width: 25,
                    height: double.infinity,
                    child: SvgPicture.asset(
                      Assets.icons('three-dots-horizontal.svg'),
                      width: 20,
                      height: 20,
                    ),
                  )),
            )
          ]
        ],
      ),
    );
  }

  void deleteListener(
      BuildContext context, DeletePostState state, PostViewModel post) {
    final localize = AppLocalizations.of(context)!;

    if (state is DeleteProcessState && state.postId == post.postId) {
      Dialogs.showModal(
          context,
          Center(
            child: AppAnimations.circleIndicator,
          ));
    } else {
      Dialogs.hide(context);
    }

    if (state is DeleteSuccessState && state.postId == post.postId) {
      context.read<ProfileRepository>().getUserPosts();
    }
    if (state is DeleteFailState && state.postId == post.postId) {
      ScaffoldMessenger.of(context)
          .showSnackBar(AppSnackBars.snackBar(localize.delete_fail));
    }
  }

//  TODO rename
  void showPostActions(PostViewModel post) {
    AppModalBottomSheet.show(
        context,
        ReportModalBottomSheet(
          postId: widget.postId,
        ));
  }

// TODO rename
  void showPostActions1(PostViewModel post) {
    AppModalBottomSheet.show(context, PostActionsBottomSheet(post: post));
  }
}

class PostReportLineWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final Function onTap;

  const PostReportLineWidget(
      {super.key,
      required this.iconPath,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              color: AppColors.white,
              width: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: AppFonts.font14w300.copyWith(color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
