import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  static final _users = FirebaseCollections.usersCollection;

  List<UserModel> socialUserList = [];

  BehaviorSubject<LoadingStateEnum> socialUserListState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

  void filterUserByInputText(String name) async {}

  void getAllUsers() async {
    socialUserList = ((await _users.get()).docs)
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }
}
