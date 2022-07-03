import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/create_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';

import '../../domain/errors/auth_errors.dart';
import '../../domain/usecases/authenticate_with_email_and_password.dart';

import '../../infra/datasources/account_datasource.dart';

class AccountDatasourceFirebaseImpl extends AccountDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  AccountDatasourceFirebaseImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
  });

  @override
  Future<Map> getCurrentUser() async {
    try {
      final account = firebaseAuth.currentUser;

      final users = await firebaseFirestore.collection('users').where('uid', isEqualTo: account?.uid).get();
      final user = users.docs.first;
    
       return {
        'id': user['uid'],
        'name': user['name'],
        'email': user['email'],
      };
    } catch (error) {
      throw AuthException(
        message: 'não existe um usuário logado',
      );
    }
  }

  @override
  Future<Map> createUser(CreateUserCredentials params) async {
    try {
      final account = await firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      final CollectionReference users =
          firebaseFirestore.collection('users');

      await users.add({
        'name': params.name,
        'email': params.email,
        'uid': account.user!.uid
      });

      return {
        'id': account.user!.uid,
        'name': params.name,
        'email': account.user!.email,
      };
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
        case 'wrong-email':
        case 'wrong-password':
          throw InvalidCredentialException();
        default:
          throw AuthException(
            message: 'Error: ${error.message}, code: ${error.code}.',
          );
      }
    }
  }

  @override
  Future<Map> signInWithEmailAndPassword(
    AuthenticateWithEmailAndPasswordCredentials params,
  ) async {
    try {
      final account = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      final users = await firebaseFirestore.collection('users').where('uid', isEqualTo: account.user?.uid).get();
      final user = users.docs.first;

      return {
        'id': user['uid'],
        'name': user['name'],
        'email': user['email'],
      };
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
        case 'wrong-email':
        case 'wrong-password':
          throw InvalidCredentialException();
        default:
          throw AuthException(
            message: 'Error: ${error.message}, code: ${error.code}.',
          );
      }
    }
  }

  @override
  Future<Map> signInWithGoogle() async {
    try {
      final signinAccount = await googleSignIn.signIn();
      final googleAuth = await signinAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final account = await firebaseAuth.signInWithCredential(credential);

      final users = await firebaseFirestore.collection('users').where('uid', isEqualTo: account.user?.uid).get();
      final user = users.docs.first;

      return {
        'id': user['uid'],
        'name': user['name'],
        'email': user['email'],
      };
    } on FirebaseAuthException catch (error) {
      throw AuthException(
        message: 'Error: ${error.message}, code: ${error.code}.',
      );
    } on PlatformException catch (error) {
      throw AuthException(
        message: 'Error: ${error.message}, code: ${error.code}.',
      );
    }
  }

  @override
  Future<Map> signInWithApple() async {
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

      final account = await firebaseAuth.signInWithCredential(oauthCredential);

      final users = await firebaseFirestore.collection('users').where('uid', isEqualTo: account.user?.uid).get();
      final user = users.docs.first;

      return {
        'id': user['uid'],
        'name': user['name'],
        'email': user['email'],
      };
    } on FirebaseAuthException catch (error) {
      throw AuthException(
        message: 'Error: ${error.message}, code: ${error.code}.',
      );
    } on PlatformException catch (error) {
      throw AuthException(
        message: 'Error: ${error.message}, code: ${error.code}.',
      );
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
