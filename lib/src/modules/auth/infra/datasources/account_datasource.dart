import '../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../domain/usecases/create_user.dart';

abstract class AccountDatasource {
  Future<Map> signInWithEmailAndPassword(AuthenticateWithEmailAndPasswordCredentials params);
  Future<Map> createUser(CreateUserCredentials params);
  Future<void> recoverPassword(String email);
  Future<Map> signInWithGoogle();
  Future<Map> signInWithApple();
  Future<Map> getCurrentUser();
}