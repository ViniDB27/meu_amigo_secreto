import 'package:dartz/dartz.dart';

import '../errors/auth_errors.dart';
import '../entities/account_entity.dart';

abstract class AuthenticateWithEmailAndPassword {
  Future<Either<AuthException, AccountEntity>> call(
    AuthenticateWithEmailAndPasswordCredentials credentials,
  );
}

class AuthenticateWithEmailAndPasswordCredentials {
  final String email;
  final String password;

  AuthenticateWithEmailAndPasswordCredentials({
    required this.email,
    required this.password,
  });
}
