import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/auth_errors.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/repositories/auth_repository_firebase_impl.dart';
import 'package:meu_amigo_secreto/src/modules/auth/infra/datasources/account_datasource.dart';

class AccountDatasourceSpy extends Mock implements AccountDatasource {}

void main() {
  late AccountDatasource accountDatasource;
  late AuthRepository sut;
  late AuthenticateWithEmailAndPasswordParams params;

  setUp(() {
    accountDatasource = AccountDatasourceSpy();
    sut = AuthRepositoryFirebaseImpl(accountDatasource);
    params = AuthenticateWithEmailAndPasswordParams(
      email: 'testando@testando.com',
      password: '123456',
    );
  });

  test('Should return an AccountEntity if success', () async {
    when(() => accountDatasource.signInWithEmailAndPasswordParams(params))
        .thenAnswer((_) async => {
              'id': '1',
              'name': 'test',
              'email': 'testando@testando.com',
            });

    final result = await sut.signInWithEmailAndPasswordParams(params);

    expect(result.fold(id, id), isA<AccountEntity>());
  });

  test('Should throw AuthException if credentials is invalid', () async {
    when(() => accountDatasource.signInWithEmailAndPasswordParams(params))
        .thenThrow(InvalidCredentialException());

    final result = await sut.signInWithEmailAndPasswordParams(params);

    expect(result.fold(id, id), isA<AuthException>());
  });
}
