import 'package:dartz/dartz.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/create_user.dart';

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
  Future<Either<AuthException, AccountEntity>> signInWithEmailAndPassword(
      AuthenticateWithEmailAndPasswordCredentials credentials) async {
    try {
      final map =
          await accountDatasource.signInWithEmailAndPassword(credentials);

      final account = AccountAdapter.fromJson(map);
      return right(account);
    } on AuthException catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<AuthException, AccountEntity>> signInWithGoogle() async {
    try {
      final map = await accountDatasource.signInWithGoogle();

      final account = AccountAdapter.fromJson(map);
      return right(account);
    } on AuthException catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<AuthException, AccountEntity>> signInWithApple() async {
    try {
      final map = await accountDatasource.signInWithApple();

      final account = AccountAdapter.fromJson(map);
      return right(account);
    } on AuthException catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<AuthException, AccountEntity>> createUser(
    CreateUserCredentials credentials,
  ) async {
    try {
      final map = await accountDatasource.createUser(credentials);

      final account = AccountAdapter.fromJson(map);
      return right(account);
    } on AuthException catch (error) {
      return left(error);
    }
  }
}
