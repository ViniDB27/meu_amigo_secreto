import 'package:dartz/dartz.dart';

import '../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/errors/auth_errors.dart';

import '../adapters/account_adapter.dart';
import '../datasources/account_datasource.dart';

class AuthRepositoryFirebaseImpl extends AuthRepository {
  final AccountDatasource accountDatasource;

  AuthRepositoryFirebaseImpl(this.accountDatasource);

  @override
  Future<Either<AuthException, AccountEntity>> signInWithEmailAndPasswordParams(AuthenticateWithEmailAndPasswordCredentials credentials) async {
     try {
      final map = await accountDatasource.signInWithEmailAndPasswordParams(credentials);

      final account = AccountAdapter.fromJson(map);
      return right(account);
    } on AuthException catch (error) {
      return left(error);
    }
  }
}