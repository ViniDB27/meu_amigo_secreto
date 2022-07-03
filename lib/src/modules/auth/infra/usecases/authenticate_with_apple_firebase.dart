import 'package:dartz/dartz.dart';

import '../../domain/usecases/authenticate_with_apple.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/errors/auth_errors.dart';

class AuthenticateWithAppleImpl extends AuthenticateWithApple {
  final AuthRepository repository;

  AuthenticateWithAppleImpl(this.repository);

  @override
  Future<Either<AuthException, AccountEntity>> call() async {
    return repository.signInWithApple();
  }
}
