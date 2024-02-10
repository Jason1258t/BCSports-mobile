import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:rxdart/subjects.dart';

class ChatRepository {
  static final _users = FirebaseCollections.usersCollection;

  List<UserModel> socialUserList = [];

  BehaviorSubject<LoadingStateEnum> socialUserListState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

   List<UserModel> filteredUserList = [];

  Future<void> getAllUsers() async {
    socialUserList = ((await _users.get()).docs)
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
    print(socialUserList);
  }

  void filterUserByInputText(String name){
    filteredUserList = socialUserList
        .where((user) => (user.displayName ?? "").startsWith(name))
        .toList();
  }
}
