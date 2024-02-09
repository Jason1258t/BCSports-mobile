import 'dart:developer';
import 'dart:io';

import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/models/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProfileRepository implements PostSource {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static final CollectionReference _users =
      _firestore.collection(FirebaseCollectionNames.users);
  static final CollectionReference _postsCollection =
      _firestore.collection(FirebaseCollectionNames.posts);

  final LikesManager likesManager;

  ProfileRepository(this.likesManager);

  BehaviorSubject<LoadingStateEnum> profileState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> userPostsState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  ProfileTabsEnum activeTab = ProfileTabsEnum.nft;

  final List<PostViewModel> posts = [];
  List<NftModel> userNftList = [];

  UserModel? _userModel;

  UserModel get user => _userModel!;

  @override
  PostViewModel? getCachedPost(String postId) {
    for (var i in posts) {
      if (i.postModel.id == postId) return i;
    }

    return null;
  }

  void setUser(String userId) async {
    profileState.add(LoadingStateEnum.loading);
    try {
      final res = await _users.doc(userId).get();

      _userModel = UserModel.fromJson(res.data() as Map<String, dynamic>);
      getUserPosts();
      profileState.add(LoadingStateEnum.success);
    } catch (e) {
      profileState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  Future<List> getUserPostLikes(String userId) async {
    return likesManager.getUserPostLikes(userId);
  }

  void getUserPosts() async {
    userPostsState.add(LoadingStateEnum.loading);
    posts.clear();
    try {
      final querySnapshot = await _postsCollection
          .orderBy('createdAtMs', descending: true)
          .where('creatorId', isEqualTo: user.id)
          .get();

      final newPosts = <PostViewModel>[];
      for (var doc in querySnapshot.docs) {
        final post =
            PostModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        final user = _userModel!;
        newPosts.add(PostViewModel(user, post));
      }

      posts.addAll(newPosts);
      mergeWithLikes(await getUserPostLikes(user.id));
      userPostsState.add(LoadingStateEnum.success);
    } catch (e) {
      userPostsState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  Future<void> editUser(
      String? newUserName, String? newDisplayName, String? newAvatar) async {
    try {
      final editedUser =
          _userModel?.copyWith(newUserName, newDisplayName, newAvatar);

      await _users.doc(_userModel!.id).set(editedUser!.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteOldUserAvatar() async {
    try {
      final storageRef = _storage.ref(FirebaseCollectionNames.userAvatar);

      if (_userModel!.avatarUrl != null) {
        await storageRef.child(_userModel!.id.toString()).delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadAvatar(String filePath) async {
    final storageRef = _storage.ref(FirebaseCollectionNames.userAvatar);
    final fileRef = storageRef.child(_userModel!.id.toString());

    final TaskSnapshot task;
    try {
      File file = File(filePath);
      task = await fileRef.putFile(file);

      return task.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> payForBid({required double price}) async {
    final user = _firestore.collection("users").doc(_userModel!.id);
    await user.update({"evmBill": _userModel!.evmBill - price});
    _userModel!.evmBill = _userModel!.evmBill - price;

    log("You paid for a bid! user: ${user.id}");
  }

  Future<void> markFavourite(NftModel nft) async {
    final dbUser = _firestore.collection("users").doc(_userModel!.id);
    await dbUser.update({
      'favourites_list': FieldValue.arrayUnion([nft.documentId])
    });
    _userModel!.favouritesNftList.add(nft.documentId);

    log("New fav-s item for ${user.id}");
  }

  Future<void> removeFromFavourites(NftModel nft) async {
    final dbUser = _firestore.collection("users").doc(_userModel!.id);
    await dbUser.update({
      'favourites_list': FieldValue.arrayRemove([nft.documentId])
    });
    _userModel!.favouritesNftList.remove(nft.documentId);

    log("**Removed** fav-s item for ${user.id}");
  }

  Future<void> loadUserNftList() async {
    final playersCollection =
        await _firestore.collection(FirebaseCollectionNames.playersNft).get();
    playersCollection.docs.forEach((doc) {
      print(doc);
      if (_userModel!.ownUserNftList.contains(doc.id)) {
        final NftModel nft = NftModel.fromJson(doc.data(), doc.id);
        userNftList.add(nft);
      }
    });

    log("Loaded user nft list: ${userNftList}");
  }

  void setProfileActiveTab(ProfileTabsEnum tab) {
    activeTab = tab;
  }

  @override
  Future likePost(String postId, String userId) async {
    await likesManager.likePost(postId, userId, posts);
  }

  @override
  void setPostLiked(String postId, bool value) {
    likesManager.setPostLiked(postId, value, posts);
  }

  @override
  Future unlikePost(String postId, String userId) async {
    await likesManager.unlikePost(postId, userId, posts);
  }

  @override
  List<PostViewModel> mergeWithLikes(List likes) {
    return likesManager.mergeWithLikes(likes, posts);
  }
}
