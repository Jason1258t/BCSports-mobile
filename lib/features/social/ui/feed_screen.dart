import 'package:bcsports_mobile/features/profile/data/profile_view_repository.dart';
import 'package:bcsports_mobile/features/social/bloc/home/home_social_cubit.dart';
import 'package:bcsports_mobile/features/social/bloc/like/like_cubit.dart';
import 'package:bcsports_mobile/features/social/data/social_repository.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/routes/route_names.dart';
import 'package:bcsports_mobile/utils/animations.dart';
import 'package:bcsports_mobile/utils/assets.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/widgets/appBar/empty_app_bar.dart';
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
        appBar: EmptyAppBar(
          title: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<LikeCubit>(context).getFavourites();
                    Navigator.pushNamed(context, AppRouteNames.favouritesPost);
                  },
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
                  repository.refreshPosts();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) => FeedPostWidget(
                          userId: repository.posts[index].user.id,
                          postId: repository.posts[index].postModel.id,
                          source: repository,
                        ),
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
