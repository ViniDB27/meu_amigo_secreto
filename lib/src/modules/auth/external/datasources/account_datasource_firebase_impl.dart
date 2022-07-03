import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/errors/auth_errors.dart';
import '../../domain/usecases/authenticate_with_email_and_password.dart';

import '../../infra/datasources/account_datasource.dart';

class AccountDatasourceFirebaseImpl extends AccountDatasource {
  final FirebaseAuth firebaseAuth;

  AccountDatasourceFirebaseImpl(this.firebaseAuth);

  @override
  Future<Map> signInWithEmailAndPasswordParams(
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
}
