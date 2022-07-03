import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/get_current_user.dart';

import '../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../domain/usecases/create_user.dart';

abstract class AccountDatasource {
  Future<Map> signInWithEmailAndPassword(AuthenticateWithEmailAndPasswordCredentials params);
  Future<Map> createUser(CreateUserCredentials params);
  Future<Map> signInWithGoogle();
  Future<Map> signInWithApple();
  Future<Map> getCurrentUser();
}