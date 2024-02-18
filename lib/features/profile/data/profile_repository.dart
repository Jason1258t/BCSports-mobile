import 'dart:developer';
import 'dart:io';

import 'package:bcsports_mobile/features/market/data/nft_service.dart';
import 'package:bcsports_mobile/features/social/data/likes_manager.dart';
import 'package:bcsports_mobile/features/social/data/models/like_action_data.dart';
import 'package:bcsports_mobile/features/social/data/models/post_model.dart';
import 'package:bcsports_mobile/features/social/data/post_source.dart';
import 'package:bcsports_mobile/features/social/data/models/post_view_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/models/market/market_item_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/exceptions.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProfileRepository extends PostSource {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  final NftService nftService;

  static final _users = FirebaseCollections.usersCollection;
  static final _postsCollection = FirebaseCollections.postsCollection;

  @override
  final LikesManager likesManager;

  @override
  final List<PostViewModel> posts = [];

  @override
  final BehaviorSubject<LikeChangesData> likeChanges = BehaviorSubject();

  ProfileRepository(this.likesManager, this.nftService) {
    likesManager.addSource(this);
  }

  BehaviorSubject<LoadingStateEnum> profileState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> userPostsState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> userNftStream =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  ProfileTabsEnum activeTab = ProfileTabsEnum.nft;

  List<NftModel> userNftList = [];

  UserModel? _userModel;

  UserModel get user => _userModel!;

  Future<void> setUser(String userId) async {
    await getUserData(userId);
    getUserPosts();
    getUserCommentLikes();
  }

  Future getUserData(String userId) async {
    profileState.add(LoadingStateEnum.loading);

    try {
      final res = await _users.doc(userId).get();

      _userModel = UserModel.fromJson(res.data() as Map<String, dynamic>);
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

  Future<void> deletePost(String postId) async {
    await _postsCollection.doc(postId).delete();
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

  Future saveDisplayName(String name) async {
    await _users
        .doc(user.id)
        .set({'displayName': name}, SetOptions(merge: true));

    getUserData(user.id);
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

  Future<void> buyNft({required MarketItemModel product}) async {
    await placeNftIntoInventory(product);
    await sendNftPriceToSeller(product);
    await payForNft(product);
  }

  Future<void> placeNftIntoInventory(MarketItemModel product) async {
    final user = _users.doc(_userModel!.id);

    Map updatedCollection = _userModel!.userNftList;
    if (updatedCollection.keys.contains(product.nft.documentId)) {
      updatedCollection[product.nft.documentId] += 1;
    } else {
      updatedCollection[product.nft.documentId] = 1;
    }

    await user.update({"user_nft": updatedCollection});

    _userModel!.userNftList = updatedCollection;
  }

  Future<void> payForNft(MarketItemModel product) async {
    final userColl = _users.doc(_userModel!.id);
    await userColl
        .update({"evmBill": _userModel!.evmBill - product.currentPrice});
    _userModel!.evmBill = _userModel!.evmBill - product.currentPrice;
  }

  Future<void> sendNftPriceToSeller(MarketItemModel product) async {
    final seller = _users.doc(product.lastOwnerId);
    await seller
        .update({"evmBill": FieldValue.increment(product.currentPrice)});
  }

  Future<void> markFavourite(MarketItemModel product) async {
    final dbUser = _users.doc(_userModel!.id);
    await dbUser.update({
      'favourites_list': FieldValue.arrayUnion([product.id])
    });
    _userModel!.favouritesNftList.add(product.id);

    log("New fav-s item for ${user.id}");
  }

  Future<void> removeFromFavourites(MarketItemModel nft) async {
    final dbUser = _users.doc(_userModel!.id);
    await dbUser.update({
      'favourites_list': FieldValue.arrayRemove([nft.id])
    });
    _userModel!.favouritesNftList.remove(nft.id);

    log("**Removed** fav-s item for ${user.id}");
  }

  Future<void> sellNft(NftModel nft, double newPrice) async {
    final marketColl = FirebaseCollections.marketCollection;
    marketColl.add(MarketItemModel.create(
        currentPrice: newPrice,
        lastOwnerId: _userModel!.id,
        lastSaleDate: DateTime.now(),
        nftId: nft.documentId));

    final userDoc = _users.doc(_userModel!.id);
    final userData = await userDoc.get();
    Map nftCollection = userData.data()!['user_nft'];
    if (nftCollection[nft.documentId] == 1) {
      nftCollection.remove(nft.documentId);
    } else {
      nftCollection[nft.documentId] -= 1;
    }

    await userDoc.update({'user_nft': nftCollection});
    await setUser(_userModel!.id);
    await loadUserNftList();
  }

  Future<void> loadUserNftList() async {
    userNftStream.add(LoadingStateEnum.loading);
    userNftList.clear();
    final dbUser = _users.doc(_userModel!.id);
    final snapshot = await dbUser.get();

    Map<dynamic, dynamic> user = snapshot.data() ?? {};
    Map<dynamic, dynamic> nftData = user['user_nft'] ?? {};

    for (var item in nftData.entries) {
      final nftModel = await nftService.loadNftData(item.key);
      for (int i = 0; i < item.value; i++) {
        userNftList.add(nftModel);
      }
    }
    userNftStream.add(LoadingStateEnum.success);
    log("Loaded user nft list: $userNftList");
  }

  void setProfileActiveTab(ProfileTabsEnum tab) {
    activeTab = tab;
  }
}
