import 'package:bcsports_mobile/features/social/bloc/home/home_social_cubit.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<SocialRepository>(context);

    return CustomScaffold(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    Assets.icons('heart.svg'),
                    width: 24,
                    height: 24,
                  ),
                ),
                InkWell(
                  child: SvgPicture.asset(
                    Assets.icons('message.svg'),
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<HomeSocialCubit, HomeSocialState>(
          builder: (context, state) {
            if (state is HomeSocialSuccessState) {
              return RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.black_s2new_1A1A1A,
                onRefresh: () async {
                  repository.reloadPosts();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) => FeedPostWidget(
                            post: repository.posts[index].postModel,
                            user: repository.posts[index].userModel),
                        childCount: repository.posts.length,
                      ))
                    ],
                  ),
                ),
              );
            } else {
              return CustomScaffold(
                  body: Center(
                child: AppAnimations.circleIndicator,
              ));
            }
          },
        ));
  }
}
