import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/post_comments/post_comments_cubit.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/comment_widget.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_actions_bottom_sheet.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/dialogs.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/appBar/empty_app_bar.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key, this.isYours = false});

  final bool isYours;

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PostCommentsCubit>(context);
    final repository = RepositoryProvider.of<ProfileRepository>(context);

    final localize = AppLocalizations.of(context)!;

    Future<void> showPostActions(
        PostViewModel post, Function() onDeleted) async {
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          builder: (_) => PostActionsBottomSheet(post: post, onDelete:  onDeleted,));
    }

    return CustomScaffold(
      padding: EdgeInsets.zero,
      resize: true,
      appBar: EmptyAppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonBack(onTap: () {
                bloc.closePost();
                Navigator.pop(context);
              }),
              Text(
                localize.post,
                style: AppFonts.font18w500,
              ),
              isYours
                  ? InkWell(
                      onTap: () async {
                        await showPostActions(bloc.post!, () {
                          repository.getUserPosts();

                          Navigator.pop(context);
                        });
                      },
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: SvgPicture.asset(
                          Assets.icons('three-dots-horizontal.svg'),
                          width: 20,
                          height: 20,
                        ),
                      ))
                  : const SizedBox(
                      width: 36,
                    ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<PostCommentsCubit, PostCommentsState>(
              listener: (context, state) {
                if (state is CreatingComment) {
                  Dialogs.showModal(
                      context,
                      Center(
                        child: AppAnimations.circleIndicator,
                      ));
                } else {
                  Dialogs.hide(context);
                }
              },
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: FeedPostWidget(
                        postId: bloc.post!.postModel.id,
                        source: bloc.source!,
                        commentsActive: false,
                        actionsAllowed: !isYours,
                      ),
                    ),
                    if (state is PostCommentsSuccessState ||
                        state is CommentCreateSuccess) ...[
                      SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            '${localize.comments} (${bloc.comments.length})',
                            style: AppFonts.font12w400,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) => CommentWidget(bloc.comments[index]),
                        childCount: bloc.comments.length,
                      ))
                    ] else if (!(state is PostCommentsSuccessState ||
                            state is CommentCreateSuccess) &&
                        state is! CreatingComment) ...[
                      SliverToBoxAdapter(
                        child: Center(
                          child: AppAnimations.circleIndicator,
                        ),
                      )
                    ]
                  ],
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              width: 1,
              color: AppColors.grey_727477,
            ))),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.grey_393939,
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 72 - 16,
                    child: TextField(
                      minLines: 1,
                      maxLines: 6,
                      maxLength: 250,
                      controller: messageController,
                      style: AppFonts.font14w400,
                      decoration: InputDecoration(
                          counterStyle: const TextStyle(height: 0),
                          counterText: "",
                          isDense: true,
                          hintStyle: AppFonts.font14w400,
                          hintText: localize.type_comment,
                          border: InputBorder.none),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        if (messageController.text.isNotEmpty) {
                          bloc.sendComment(messageController.text);
                          messageController.text = '';
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.all(6),
                        child:
                            SvgPicture.asset(Assets.icons('send_comment.svg')),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
