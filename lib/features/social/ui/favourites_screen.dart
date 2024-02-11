import 'package:bcsports_mobile/features/social/bloc/like/like_cubit.dart';
import 'package:bcsports_mobile/features/social/data/favourite_posts_repository.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/animations.dart';
import '../../../utils/enums.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<FavouritePostsRepository>(context);

    return CustomScaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: ButtonBack(
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => context.read<LikeCubit>().refreshFavourites(),
          child: CustomScrollView(
            slivers: [
              StreamBuilder(
                  stream: repository.postsState.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data == LoadingStateEnum.success) {
                      print('success loaded');
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) => FeedPostWidget(
                          userId: repository.posts[index].user.id,
                          postId: repository.posts[index].postModel.id,
                          source: repository,
                        ),
                        childCount: repository.posts.length,
                      ));
                    } else {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: AppAnimations.circleIndicator,
                        ),
                      );
                    }
                  })
            ],
          ),
        ));
  }
}
