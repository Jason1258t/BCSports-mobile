import 'dart:developer';
import 'dart:io';

import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  BehaviorSubject<LoadingStateEnum> profileState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  BehaviorSubject<LoadingStateEnum> editProfileState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  EnumProfileTab activeTab = EnumProfileTab.nft;

  UserModel? _userModel;

  UserModel get user => _userModel!;

  void setUser(String userId) async {
    profileState.add(LoadingStateEnum.loading);
    try {
      final res = await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(userId)
          .get();

      _userModel = UserModel.fromJson(res.data()!);

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

      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(_userModel!.id)
          .set(editedUser!.toJson());

      editProfileState.add(LoadingStateEnum.success);
    } catch (e) {
      editProfileState.add(LoadingStateEnum.fail);
      rethrow;
    }
  }

  Future<String> uploadPostImage(String filePath) async {
    final storageRef = _storage.ref(FirebaseCollectionNames.userAvatar);
    final fileRef = storageRef.child(const Uuid().v1());

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

  void setProfileActiveTab(EnumProfileTab profileTap) {
    activeTab = profileTap;
  }
}
