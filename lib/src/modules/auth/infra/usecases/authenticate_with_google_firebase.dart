import 'package:dartz/dartz.dart';

import '../../domain/usecases/authenticate_with_google.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/errors/auth_errors.dart';

class AuthenticateWithGoogleImpl extends AuthenticateWithGoogle {
  final AuthRepository repository;

  AuthenticateWithGoogleImpl(this.repository);

  @override
  Future<Either<AuthException, AccountEntity>> call() async {
    return repository.signInWithGoogle();
  }
}
