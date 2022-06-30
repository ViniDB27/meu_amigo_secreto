import 'package:dartz/dartz.dart';

import '../usecases/authenticate_with_email_and_password.dart';
import '../entities/account_entity.dart';
import '../errors/auth_errors.dart';

abstract class AuthRepository {
  Future<Either<AuthException, AccountEntity>> signInWithEmailAndPasswordParams(AuthenticateWithEmailAndPasswordParams params);
}