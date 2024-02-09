import 'dart:async';
import 'dart:math';

import 'package:bcsports_mobile/features/social/data/models/banner_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/exceptions.dart';
import 'package:bcsports_mobile/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepository {
  AuthRepository() {
    checkAuth();
    _listenAuthChanges();
  }

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  BehaviorSubject<AppAuthStateEnum> appState =
      BehaviorSubject.seeded(AppAuthStateEnum.wait);

  StreamSubscription? authSubscription;

  void _listenAuthChanges() async {
    authSubscription?.cancel();
    authSubscription = _auth.authStateChanges().listen(_authChangesListener);
  }

  String _generateTempUserName() {
    return 'user${DateTime.now().millisecondsSinceEpoch}';
  }

  Future _writeUserDataInDatabase(String userId) async {
    final collection =
        _firebaseFirestore.collection(FirebaseCollectionNames.users);

    final res = await collection.doc(userId).get();
    if (res.exists) return;
    final user = UserModel.create(
        userId,
        _generateTempUserName(),
        BannerModel.create(
            userColors[Random().nextInt(userColors.length)].value,
            AppStrings.listBannerImages[
                Random().nextInt(AppStrings.listBannerImages.length)]));

    await collection.doc(userId).set(user.toJson());
  }

  void _authChangesListener(User? user) {
    if (user == null) {
      print('User is currently signed out!');
      appState.add(AppAuthStateEnum.unAuth);
    } else {
      print('User is signed in!');
    }
  }

  Future checkAuth() async {
    if (currentUser == null) {
      appState.add(AppAuthStateEnum.unAuth);
    } else {
      appState.add(AppAuthStateEnum.auth);
    }
  }

  Future resetPassword(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _writeUserDataInDatabase(userCredential.user!.uid);
      appState.add(AppAuthStateEnum.auth);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeekPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw AccountAlreadyExistException();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _writeUserDataInDatabase(userCredential.user!.uid);
      appState.add(AppAuthStateEnum.auth);
      print('auth state added');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      }
      rethrow;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    await _writeUserDataInDatabase(userCredential.user!.uid);
    appState.add(AppAuthStateEnum.auth);
    return userCredential;
  }

  Future signOut() async {
    await _auth.signOut();
    appState.add(AppAuthStateEnum.unAuth);
  }
}
