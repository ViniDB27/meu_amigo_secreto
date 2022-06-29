import 'package:firebase_auth/firebase_auth.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/errors.dart';
import 'package:meu_amigo_secreto/src/modules/auth/infra/datasources/account_datasource.dart';

class AccountDatasourceFirebaseImpl extends IAccountDatasource {
  final FirebaseAuth firebaseAuth;

  AccountDatasourceFirebaseImpl({required this.firebaseAuth});

  @override
  Future<Map> login({
    required String email,
    required String password,
  }) async {
    try {
      final account = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return {
        'id': account.user!.uid,
        'name': account.user!.displayName,
        'token': account.credential!.token,
      };
    } on FirebaseAuthException catch (error) {
      throw AuthException(
        message: 'Error: ${error.message}, code: ${error.code}.',
      );
    }
  }
}
