import 'package:dartz/dartz.dart';

import '../errors/auth_errors.dart';
import '../entities/account_entity.dart';

abstract class AuthenticateWithEmailAndPassword {
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
