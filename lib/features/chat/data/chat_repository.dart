import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:rxdart/subjects.dart';

class ChatRepository {
  static final _users = FirebaseCollections.usersCollection;
  static final chatCore = FirebaseChatCore.instance;

  List<Room> rooms = [];

  final Stream<List<Room>> roomsStream = chatCore.rooms();

  List<UserModel> socialUserList = [];

  BehaviorSubject<LoadingStateEnum> socialUserListState =
  BehaviorSubject.seeded(LoadingStateEnum.wait);

  List<UserModel> filteredUserList = [];

  UserModel? activeUser;

  ChatRepository() {
    FirebaseChatCore.instance
        .setConfig(const FirebaseChatCoreConfig(null, 'rooms', 'chat_users'));
    subscribeRoomsUpdates();
  }

  void setActiveUser(UserModel user){
    activeUser = user;
  }

  void subscribeRoomsUpdates() {
    chatCore.rooms().listen((event) {
      rooms = event;
    });
  }

  UserModel? getUserById(String userId) {
    for (var i in socialUserList) {
      if (i.id == userId) return i;
    }

    return null;
  }

  static Future createUserInFirestore(UserModel user) async {
    await FirebaseChatCore.instance.createUserInFirestore(user.toChatUser());
  }

  Future<Room> createRoomWithUser(UserModel user) async {
    final room = await FirebaseChatCore.instance.createRoom(User(
        id: user.id,
        firstName: user.displayName ?? user.username,
        imageUrl: user.avatarUrl));
    return room;
  }

  Future sendMessage(String roomId, message) async {
    chatCore.sendMessage(message, roomId);
  }

  Future<Room?> roomWithUserExists(String userId) async {
    for (var room in rooms) {
      for (var user in room.users) {
        if (user.id == userId) return room;
      }
    }
    return null;
  }

  Future<void> getAllUsers() async {
    final res = (await _users.get()).docs;
    print(res);
    res.forEach((element) {
      print(element.data());
    });

    socialUserList = res.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  void filterUserByInputText(String name, String youId) {
    filteredUserList =
        socialUserList.where((user) => (user.username).contains(name) && user.id != youId).toList();
  }
}
