import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseCollectionNames {
  static const String users = 'users';
  static const String posts = 'posts';
  static const String comments = 'comments';
  static const String postsBucket = '/feed_post_images';
  static const String userAvatar = '/user_avatar';
  static const String playersNft = 'players_NFT';
  static const String chatUsers = 'chat_users';
}

abstract class FirebaseCollections {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final usersCollection =
      _firestore.collection(FirebaseCollectionNames.users);
  static final commentsCollection =
      _firestore.collection(FirebaseCollectionNames.comments);
  static final postsCollection =
      _firestore.collection(FirebaseCollectionNames.posts);
  static final playersNftCollection =
      _firestore.collection(FirebaseCollectionNames.playersNft);
}
