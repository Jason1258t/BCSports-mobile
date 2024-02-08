import 'dart:developer';
import 'dart:io';

import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/models/market/nft_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ProfileRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static final CollectionReference _users =
      _firestore.collection(FirebaseCollectionNames.users);

  BehaviorSubject<LoadingStateEnum> profileState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> editProfileState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  ProfileTabsEnum activeTab = ProfileTabsEnum.nft;

  UserModel? _userModel;

  UserModel get user => _userModel!;

  void setUser(String userId) async {
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

  Future<void> editUser(
      String? newUserName, String? newDisplayName, String? newAvatar) async {
    editProfileState.add(LoadingStateEnum.loading);
    try {
      final editedUser =
          _userModel?.copyWith(newUserName, newDisplayName, newAvatar);

      await _users
          .doc(_userModel!.id)
          .set(editedUser!.toJson());

      editProfileState.add(LoadingStateEnum.success);
    } catch (e) {
      editProfileState.add(LoadingStateEnum.fail);
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

  void setProfileActiveTab(ProfileTabsEnum tab) {
    activeTab = tab;
  }
}
