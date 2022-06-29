import 'package:dartz/dartz.dart';
import 'package:meu_amigo_secreto/src/modules/auth/infra/adapters/account_adapter.dart';

import '../../domain/usecases/authenticate_with_email_and_password.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/errors/errors.dart';

import '../datasources/account_datasource.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final IAccountDatasource accountDatasource;

  AuthRepositoryImpl({
    required this.accountDatasource,
  });

  @override
  Future<Either<AuthException, AccountEntity>> login({
    required AuthenticateWithEmailAndPasswordParams params,
  }) async {
    try {
      final map = await accountDatasource.login(
        email: params.email,
        password: params.password,
      );

      final account = AccountAdapter.fromJson(map);
      return right(account);
    } on AuthException catch (error) {
      return left(error);
    }
  }
}
