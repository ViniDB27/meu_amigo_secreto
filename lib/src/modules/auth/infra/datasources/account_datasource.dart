import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';

abstract class AccountDatasource {
  Future<Map> signInWithEmailAndPassword(AuthenticateWithEmailAndPasswordCredentials params);
  Future<Map> signInWithGoogle();
  Future<Map> signInWithApple();
}