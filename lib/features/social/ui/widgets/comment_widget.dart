import 'package:bcsports_mobile/features/main/bloc/cubit/main_cubit.dart';
import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/post_comments/post_comments_cubit.dart';
import 'package:bcsports_mobile/features/social/data/models/comment_view_model.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/small_avatar.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/utils/time_difference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget(this.comment, {super.key});

  final CommentViewModel comment;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    final profileRepository = RepositoryProvider.of<ProfileRepository>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: InkWell(
        onTap: (){
          if(widget.comment.user.id != profileRepository.user.id){
            context.read<ProfileViewRepository>().setUser(widget.comment.user.id);
            Navigator.pushNamed(context, AppRouteNames.profileView);
          }
          else {
            context.read<MainCubit>().changePageIndexTo(3);
            Navigator.pop(context);
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallAvatarWidget(user: widget.comment.user),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.comment.user.displayName ??
                        widget.comment.user.username,
                    style: AppFonts.font12w400
                        .copyWith(color: const Color(0xffEBEAEC)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.comment.text,
                    style: AppFonts.font14w400,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${DateTimeDifferenceConverter.diffToString(widget.comment.createdAt)} • ${widget.comment.likesCount} Likes',
                    style: AppFonts.font14w400
                        .copyWith(color: const Color(0xFF717477)),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () =>
                  context.read<PostCommentsCubit>().likeComment(widget.comment),
              child: SvgPicture.asset(Assets.icons(widget.comment.liked ? 'red_heart.svg': 'heart.svg')),
            )
          ],
        ),
      ),
    );
  }
}
