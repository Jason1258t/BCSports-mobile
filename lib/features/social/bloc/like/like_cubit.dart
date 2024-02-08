import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/social/data/favourite_posts_repository.dart';
import 'package:bcsports_mobile/features/social/data/models/post_source.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  final ProfileRepository profileRepository;
  final FavouritePostsRepository favouritePostsRepository;

  LikeCubit(this.profileRepository, this.favouritePostsRepository)
      : super(LikeInitial());

  void getFavourites() {
    favouritePostsRepository.getPosts(profileRepository.user.id);
  }

  void changePostLiked(String postId, bool value, PostSource source) =>
      source.setPostLiked(postId, value);

  Future likePost(String postId, PostSource source) async {
    final user = profileRepository.user;
    return source.likePost(postId, user.id);
  }

  Future unlikePost(String postId, PostSource source) async {
    final user = profileRepository.user;
    return source.unlikePost(postId, user.id);
  }
}
