import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/errors/auth_errors.dart';
import '../../domain/usecases/authenticate_with_email_and_password.dart';

import '../../infra/datasources/account_datasource.dart';

class AccountDatasourceFirebaseImpl extends AccountDatasource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AccountDatasourceFirebaseImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<Map> signInWithEmailAndPassword(
      AuthenticateWithEmailAndPasswordCredentials params) async {
    try {
      final account = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      return {
        'id': account.user!.uid,
        'name': account.user?.displayName ?? account.user!.email,
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
  Future<Map> signInWithGoogle() async {
    try {
      final signinAccount = await googleSignIn.signIn();
      final googleAuth = await signinAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final account = await firebaseAuth.signInWithCredential(credential);

      return {
        'id': account.user!.uid,
        'name': account.user?.displayName ?? account.user!.email,
        'email': account.user!.email,
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
}
