import 'dart:developer';
import 'dart:io';

import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/exceptions.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:rxdart/rxdart.dart';

class ProfileRepository extends PostSource {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static final _users = FirebaseCollections.usersCollection;
  static final _postsCollection = FirebaseCollections.postsCollection;
  static final _playersCollection = FirebaseCollections.playersNftCollection;

  @override
  final LikesManager likesManager;

  @override
  final List<PostViewModel> posts = [];

  @override
  final BehaviorSubject<LikeChangesData> likeChanges = BehaviorSubject();

  ProfileRepository(this.likesManager) {
    likesManager.addSource(this);
  }

  BehaviorSubject<LoadingStateEnum> profileState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> userPostsState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  ProfileTabsEnum activeTab = ProfileTabsEnum.nft;

  List<NftModel> userNftList = [];

  UserModel? _userModel;

  UserModel get user => _userModel!;

  void setUser(String userId) async {
    profileState.add(LoadingStateEnum.loading);
    try {
      final res = await _users.doc(userId).get();

      _userModel = UserModel.fromJson(res.data() as Map<String, dynamic>);
      getUserPosts();
      getUserCommentLikes();
      profileState.add(LoadingStateEnum.success);
    } catch (e) {
      profileState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  final List commentLikes = [];

  void getUserCommentLikes() async {
    final res = await _users.doc(user.id).get();
    commentLikes.clear();
    commentLikes.addAll(((res.data() as Map)['commentLikes'] ?? []) as List);
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

  Future<void> editUser(
      String username, String displayName, String? avatar) async {
    try {
      final usernameValid = await isUsernameValid(username);
      if (!usernameValid) throw UsernameAlreadyUsed();

      final editedUser = user.copyWith(username, displayName, avatar);

      await _users.doc(user.id).set(editedUser.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isUsernameValid(String username) async {
    if (user.username != username) {
      final res = await _users.where('username', isEqualTo: username).get();

      if (res.docs.isEmpty) return true;
    } else {
      return true;
    }
    return false;
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
    final user = _users.doc(_userModel!.id);
    await user.update({"evmBill": _userModel!.evmBill - price});
    _userModel!.evmBill = _userModel!.evmBill - price;

    log("You paid for a bid! user: ${user.id}");
  }

  Future<void> markFavourite(NftModel nft) async {
    final dbUser = _users.doc(_userModel!.id);
    await dbUser.update({
      'favourites_list': FieldValue.arrayUnion([nft.documentId])
    });
    _userModel!.favouritesNftList.add(nft.documentId);

    log("New fav-s item for ${user.id}");
  }

  Future<void> removeFromFavourites(NftModel nft) async {
    final dbUser = _users.doc(_userModel!.id);
    await dbUser.update({
      'favourites_list': FieldValue.arrayRemove([nft.documentId])
    });
    _userModel!.favouritesNftList.remove(nft.documentId);

    log("**Removed** fav-s item for ${user.id}");
  }

  Future<void> loadUserNftList() async {
    userNftList.clear();

    final playersCollection = await _playersCollection.get();
    playersCollection.docs.forEach((doc) {
      print(doc);
      if (_userModel!.ownUserNftList.contains(doc.id)) {
        final NftModel nft = NftModel.fromJson(doc.data(), doc.id);
        userNftList.add(nft);
      }
    });

    log("Loaded user nft list: $userNftList");
  }

  void setProfileActiveTab(ProfileTabsEnum tab) {
    activeTab = tab;
  }
}
