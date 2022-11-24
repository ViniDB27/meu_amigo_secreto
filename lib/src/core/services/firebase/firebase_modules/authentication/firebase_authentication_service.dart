import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../firebase_service_exception.dart';

class FirebaseAuthenticationService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  FirebaseAuthenticationService({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
  });

  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final account = firebaseAuth.currentUser;

      if (account == null) {
        return null;
      }

      final users = await firebaseFirestore
          .collection('users')
          .where('uid', isEqualTo: account.uid)
          .get();

      if (users.docs.isEmpty) {
        return null;
      }

      final user = users.docs.first;

      return {
        'id': user['uid'],
        'name': user['name'],
        'email': user['email'],
        'avatar': user['avatar'],
        'phone': user['phone'],
      };
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> createNewAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final firebaseAccount = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final CollectionReference users = firebaseFirestore.collection('users');

      await users.add({
        'name': name,
        'email': email,
        'uid': firebaseAccount.user!.uid,
        'avatar': null,
        'phone': null,
      });
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseAccount = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final users = await firebaseFirestore
          .collection('users')
          .where('uid', isEqualTo: firebaseAccount.user?.uid)
          .get();

      final user = users.docs.first;

      return {
        "id": user['uid'],
        "name": user['uid'],
        "email": user['uid'],
        'avatar': user['avatar'],
        'phone': user['phone'],
      };
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final firebaseAccount =
          await firebaseAuth.signInWithCredential(credential);

      final CollectionReference userCollection =
          firebaseFirestore.collection('users');

      final users = await userCollection
          .where('uid', isEqualTo: firebaseAccount.user?.uid)
          .get();

      if (users.docs.isEmpty) {
        await userCollection.add({
          'name': firebaseAccount.user!.displayName,
          'email': firebaseAccount.user!.email,
          'uid': firebaseAccount.user!.uid,
          'avatar': firebaseAccount.user!.photoURL,
          'phone': firebaseAccount.user!.phoneNumber,
        });
      }
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> signInWithApple() async {
    try {
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
      final firebaseAccount =
          await firebaseAuth.signInWithCredential(oauthCredential);

      final CollectionReference userCollection =
          firebaseFirestore.collection('users');

      final users = await userCollection
          .where('uid', isEqualTo: firebaseAccount.user?.uid)
          .get();

      if (users.docs.isEmpty) {
        await userCollection.add({
          'name': firebaseAccount.user!.displayName,
          'email': firebaseAccount.user!.email,
          'uid': firebaseAccount.user!.uid,
          'avatar': firebaseAccount.user!.photoURL,
          'phone': firebaseAccount.user!.phoneNumber,
        });
      }
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
