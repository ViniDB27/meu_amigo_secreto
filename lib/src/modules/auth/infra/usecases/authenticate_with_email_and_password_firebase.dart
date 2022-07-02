import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

import '../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/errors/auth_errors.dart';

class AuthenticateWithEmailAndPasswordOnFirebase
    extends AuthenticateWithEmailAndPassword {
  final AuthRepository repository;

  AuthenticateWithEmailAndPasswordOnFirebase(this.repository);

  @override
  Future<Either<AuthException, AccountEntity>> call(
      AuthenticateWithEmailAndPasswordCredentials credentials) async {
    if (!isEmail(credentials.email) || credentials.password.isEmpty) {
      return left(InvalidCredentialException());
    }

    return repository.signInWithEmailAndPasswordParams(credentials);
  }
}
