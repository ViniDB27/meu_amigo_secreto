import 'package:dartz/dartz.dart';
import 'package:string_validator/string_validator.dart';

import '../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/errors/errors.dart';

class AuthenticateWithEmailAndPassword
    extends IAuthenticateWithEmailAndPassword {
  final IAuthRepository repository;

  AuthenticateWithEmailAndPassword({required this.repository});

  @override
  Future<Either<AuthException, AccountEntity>> call({
    required AuthenticateWithEmailAndPasswordParams params,
  }) async {
    if (!isEmail(params.email)) {
      return left(AuthException(message: 'Invalid Credentials'));
    }

    if (params.password.isEmpty) {
      return left(AuthException(message: 'Invalid Credentials'));
    }

    return repository.login(params: params);
  }
}
