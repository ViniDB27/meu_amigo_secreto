import 'package:firebase_auth/firebase_auth.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/auth_errors.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';
import 'package:meu_amigo_secreto/src/modules/auth/infra/datasources/account_datasource.dart';

class AccountDatasourceFirebaseImpl extends AccountDatasource {
  final FirebaseAuth firebaseAuth;

  AccountDatasourceFirebaseImpl(this.firebaseAuth);

  @override
  Future<Map> signInWithEmailAndPasswordParams(AuthenticateWithEmailAndPasswordParams params) async {
    try {
      final account = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      return {
        'id': account.user!.uid,
        'name': account.user!.displayName,
        'email': account.user!.email,
      };
    } on FirebaseAuthException catch (error) {
      throw AuthException(
        message: 'Error: ${error.message}, code: ${error.code}.',
      );
    }
  }
}