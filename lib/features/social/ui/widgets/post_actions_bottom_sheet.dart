import 'package:bcsports_mobile/features/social/bloc/delete_post/delete_post_cubit.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostActionsBottomSheet extends StatelessWidget {
  const PostActionsBottomSheet({super.key, required this.post, this.onDelete});

  final PostViewModel post;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 64),
      // height: 140,
      decoration: BoxDecoration(
          color: AppColors.black_s2new_1A1A1A,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 2,
            decoration: ShapeDecoration(
              color: AppColors.grey_B3B3B3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextButton(
            text: localize.delete,
            onTap: () {
              context.read<DeletePostCubit>().deletePost(post.postId);
              Navigator.pop(context);

              if(onDelete != null){
                onDelete!();
              }
            },
            isActive: true,
            height: 40,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
