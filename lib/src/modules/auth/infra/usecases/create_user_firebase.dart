import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

import '../../domain/usecases/create_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/errors/auth_errors.dart';

class CreateUserImpl extends CreateUser {
  final AuthRepository repository;

  CreateUserImpl(this.repository);

  @override
  Future<Either<AuthException, AccountEntity>> call(
      CreateUserCredentials credentials) async {
    if (!isEmail(credentials.email) ||
        credentials.password.isEmpty ||
        credentials.name.isEmpty) {
      return left(InvalidCredentialException());
    }

    return repository.createUser(credentials);
  }
}
