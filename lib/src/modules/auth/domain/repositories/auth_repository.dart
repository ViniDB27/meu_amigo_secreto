import 'package:dartz/dartz.dart';

import '../usecases/authenticate_with_email_and_password.dart';
import '../entities/account_entity.dart';
import '../usecases/create_user.dart';
import '../errors/auth_errors.dart';

abstract class AuthRepository {
  Future<Either<AuthException, AccountEntity>> signInWithEmailAndPassword(AuthenticateWithEmailAndPasswordCredentials credentials);
  Future<Either<AuthException, AccountEntity>> createUser(CreateUserCredentials credentials);
  Future<Either<AuthException, void>> recoverPassword(String email);
  Future<Either<AuthException, AccountEntity>> signInWithGoogle();
  Future<Either<AuthException, AccountEntity>> signInWithApple();
  Future<Either<AuthException, AccountEntity>> getCurrentUser();
}