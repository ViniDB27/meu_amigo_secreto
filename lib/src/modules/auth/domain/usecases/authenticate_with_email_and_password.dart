import 'package:dartz/dartz.dart';

import '../entities/account_entity.dart';
import '../errors/errors.dart';

abstract class IAuthenticateWithEmailAndPassword {
  Future<Either<AuthException, AccountEntity>> call(
      {required AuthenticateWithEmailAndPasswordParams params});
}

class AuthenticateWithEmailAndPasswordParams {
  final String email;
  final String password;

  AuthenticateWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
