import 'package:dartz/dartz.dart';

import '../errors/auth_errors.dart';
import '../entities/account_entity.dart';

abstract class CreateUser {
  Future<Either<AuthException, AccountEntity>> call(
    CreateUserCredentials credentials,
  );
}

class CreateUserCredentials {
  final String name;
  final String email;
  final String password;

  CreateUserCredentials({
    required this.name,
    required this.email,
    required this.password,
  });
}
