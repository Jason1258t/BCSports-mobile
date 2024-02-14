import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bcsports_mobile/features/chat/data/chat_repository.dart';
import 'package:bcsports_mobile/features/social/data/models/banner_model.dart';
import 'package:bcsports_mobile/features/social/data/models/user_model.dart';
import 'package:bcsports_mobile/services/firebase_collections.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/services/exceptions.dart';
import 'package:bcsports_mobile/utils/strings.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepository {
  AuthRepository() {
    checkAuth();
    _listenAuthChanges();
  }

  static final FirebaseAuth _auth = FirebaseAuth.instance;

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
    final collection = FirebaseCollections.usersCollection;
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
    await ChatRepository.createUserInFirestore(user);
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

  _handleAuthErrors(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        throw WeekPasswordException();
      case 'email-already-in-use':
        throw AccountAlreadyExistException();
      case 'user-not-found':
        throw UserNotFoundException();
      case 'wrong-password':
        throw WrongPasswordException();
      case 'invalid-credential':
        throw InvalidCredentials();
      case 'network-request-failed':
        throw NetworkFail();
      case 'channel-error':
        throw ChannelConnectionError();
    }
    print('Error code: ${e.code}');
    print('Error: $e');
  }

  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _writeUserDataInDatabase(userCredential.user!.uid);
      appState.add(AppAuthStateEnum.auth);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleAuthErrors(e);
    } catch (e) {
      print('Error: $e');
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
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleAuthErrors(e);
    }
    return null;
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

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    await _writeUserDataInDatabase(userCredential.user!.uid);
    appState.add(AppAuthStateEnum.auth);
    return userCredential;
  }

  Future signOut() async {
    await _auth.signOut();
    appState.add(AppAuthStateEnum.unAuth);
  }
}
