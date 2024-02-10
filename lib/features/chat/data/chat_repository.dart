import 'package:bcsports_mobile/features/social/data/models/user_model.dart';

class ChatRepository {
  final List<UserModel> socailUserList = [];
   List<UserModel> filteredUserList = [];

  void filterUserByInputText(String name) {
    filteredUserList = socailUserList
        .where((user) => (user.displayName ?? "").startsWith(name))
        .toList();
  }
}
