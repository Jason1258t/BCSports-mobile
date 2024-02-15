import 'package:bcsports_mobile/features/market/data/nft_service.dart';
import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:rxdart/subjects.dart';

import '../../../utils/enums.dart';

class ProfileViewRepository extends PostSource {
  final NftService nftService;

  static final _users = FirebaseCollections.usersCollection;
  static final _postsCollection = FirebaseCollections.postsCollection;
  static final _playersCollection = FirebaseCollections.playersNftCollection;

  ProfileViewRepository(this.likesManager, this.nftService) {
    likesManager.addSource(this);
  }

  @override
  late final LikesManager likesManager;

  @override
  final List<PostViewModel> posts = [];

  @override
  final BehaviorSubject<LikeChangesData> likeChanges = BehaviorSubject();

  UserModel? _userModel;

  UserModel get user => _userModel!;

  ProfileTabsEnum activeTab = ProfileTabsEnum.nft;

  List<NftModel> userNftList = [];

  BehaviorSubject<LoadingStateEnum> profileViewState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> userPostsState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  void setUser(String userId) async {
    profileViewState.add(LoadingStateEnum.loading);
    try {
      final res = await _users.doc(userId).get();

      _userModel = UserModel.fromJson(res.data() as Map<String, dynamic>);
      loadUserNftList();
      getUserPosts();

      profileViewState.add(LoadingStateEnum.success);
    } catch (e) {
      profileViewState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  void getUserPosts() async {
    userPostsState.add(LoadingStateEnum.loading);
    posts.clear();
    try {
      final querySnapshot = await _postsCollection
          .orderBy('createdAtMs', descending: true)
          .where('creatorId', isEqualTo: user.id)
          .get();

      for (var doc in querySnapshot.docs) {
        final post = PostModel.fromJson(doc.data());
        final user = _userModel!;
        posts.add(PostViewModel(user, post));
      }

      mergeWithLikes();
      userPostsState.add(LoadingStateEnum.success);
    } catch (e) {
      userPostsState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  void setProfileActiveTab(ProfileTabsEnum tab) {
    activeTab = tab;
  }

  Future<void> loadUserNftList() async {
    profileViewState.add(LoadingStateEnum.loading);
    try {
      userNftList.clear();

      final playersCollection = await _playersCollection.get();
      playersCollection.docs.forEach((doc) async {
        print(doc);
        if (_userModel!.userNftList.keys.contains(doc.id)) {

          final NftModel nft =
              NftModel.fromJson(doc.data(), doc.id);
          userNftList.add(nft);
        }
      });

      profileViewState.add(LoadingStateEnum.success);
    } catch (e) {
      profileViewState.add(LoadingStateEnum.fail);
    }
  }
}
