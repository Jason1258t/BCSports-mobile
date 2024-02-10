import 'package:bcsports_mobile/features/social/data/models/user_model.dart';

class ChatRepository {
  static final _users = FirebaseCollections.usersCollection;

  List<UserModel> socialUserList = [];

  BehaviorSubject<LoadingStateEnum> socialUserListState =
      BehaviorSubject.seeded(LoadingStateEnum.wait);

   List<UserModel> filteredUserList = [];

  void filterUserByInputText(String name) async {}

  void getAllUsers() async {
    socialUserList = ((await _users.get()).docs)
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }
  void filterUserByInputText(String name) {
    filteredUserList = socailUserList
        .where((user) => (user.displayName ?? "").startsWith(name))
        .toList();
  }
}
