import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  BehaviorSubject<LoadingStateEnum> profileState =
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

  void setProfileActiveTab(EnumProfileTab profileTap) {
    activeTab = profileTap;
  }
}
