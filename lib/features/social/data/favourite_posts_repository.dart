import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:rxdart/rxdart.dart';

class FavouritePostsRepository extends PostSource {
  static final _postsCollection = FirebaseCollections.postsCollection;
  static final _usersCollection = FirebaseCollections.usersCollection;

  @override
  final List<PostViewModel> posts = [];

  @override
  final BehaviorSubject<LikeChangesData> likeChanges = BehaviorSubject();

  @override
  final LikesManager likesManager;

  FavouritePostsRepository(
    this.likesManager,
  ) {
    likesManager.addSource(this);
  }

  BehaviorSubject<LoadingStateEnum> postsState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  Future reloadPosts(String userId) async {
    posts.clear();
    return getPosts(userId);
  }

  Future<List<PostViewModel>> getPosts(userId) async {
    if (posts.isNotEmpty) return [];

    postsState.add(LoadingStateEnum.loading);

    final likes = (await getUserPostLikes(userId)) as List;
    if(likes.isEmpty){
      postsState.add(LoadingStateEnum.success);
      return [];
    }

    final response = await _postsCollection.where('id', whereIn: likes).get();

    posts.clear();

    for (var doc in response.docs) {
      final post = PostModel.fromJson(doc.data());
      final user = await _getUserById(post.creatorId);
      posts.add(PostViewModel(user, post));
    }
    mergeWithLikes();
    postsState.add(LoadingStateEnum.success);
    return posts;
  }

  Future<UserModel> _getUserById(String userId) async {
    final res = await _usersCollection.doc(userId).get();
    return UserModel.fromJson(res.data() as Map<String, dynamic>);
  }
}
