import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/errors.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/repositories/auth_repository_impl.dart';
import 'package:meu_amigo_secreto/src/modules/auth/infra/datasources/account_datasource.dart';

class AccountDatasourceSpy extends Mock implements IAccountDatasource {}

void main() {
  late IAccountDatasource accountDatasource;
  late IAuthRepository sut;
  late AuthenticateWithEmailAndPasswordParams params;

  setUp(() {
    accountDatasource = AccountDatasourceSpy();
    sut = AuthRepositoryImpl(accountDatasource: accountDatasource);
    params = AuthenticateWithEmailAndPasswordParams(
      email: 'testando@testando.com',
      password: '123456',
    );
  });

  test('Should return an AccountEntity if success', () async {
    when(() => accountDatasource.login(
          email: params.email,
          password: params.password,
        )).thenAnswer((_) async => {
          'id': '1',
          'name': 'test',
          'token': '123456',
        });

    final result = await sut.login(params: params);

    expect(result.fold(id, id), isA<AccountEntity>());
  });

  test('Should throw AuthException if credentials is invalid', () async {
    when(() => accountDatasource.login(
          email: params.email,
          password: params.password,
        )).thenThrow(AuthException(message: 'Invalid credentials'));

    final result = await sut.login(params: params);

    expect(result.fold(id, id), isA<AuthException>());
  });
}
