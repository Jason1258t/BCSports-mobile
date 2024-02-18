import 'package:bcsports_mobile/features/social/bloc/like/like_cubit.dart';
import 'package:bcsports_mobile/features/social/data/favourite_posts_repository.dart';
import 'package:bcsports_mobile/features/social/ui/widgets/post_widget.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
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

    final localize = AppLocalizations.of(context)!;

    return CustomScaffold(
      padding: EdgeInsets.zero,
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
                    if (snapshot.data == LoadingStateEnum.success && repository.posts.isNotEmpty) {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) => FeedPostWidget(
                          postId: repository.posts[index].postModel.id,
                          source: repository,
                        ),
                        childCount: repository.posts.length,
                      ));
                    }
                    else if(snapshot.data == LoadingStateEnum.success && repository.posts.isEmpty){
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text('You haven\'t favorites', style: AppFonts.font18w400,), //TODO
                        ),
                      );
                    }
                    else {
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
