import 'package:dartz/dartz.dart';

import '../usecases/authenticate_with_email_and_password.dart';
import '../entities/account_entity.dart';
import '../errors/errors.dart';

abstract class IAuthRepository {
  Future<Either<AuthException, AccountEntity>> login({required AuthenticateWithEmailAndPasswordParams params});
}
