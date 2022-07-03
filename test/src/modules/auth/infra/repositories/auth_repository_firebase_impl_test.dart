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
  late AuthenticateWithEmailAndPasswordCredentials params;

  setUp(() {
    accountDatasource = AccountDatasourceSpy();
    sut = AuthRepositoryFirebaseImpl(accountDatasource);
    params = AuthenticateWithEmailAndPasswordCredentials(
      email: 'testando@testando.com',
      password: '123456',
    );
  });

  //Authenticate With Email And Password Tests
  test(
      'Authenticate With Email And Password: Should return an AccountEntity if success',
      () async {
    when(() => accountDatasource.signInWithEmailAndPassword(params))
        .thenAnswer((_) async => {
              'id': '1',
              'name': 'test',
              'email': 'testando@testando.com',
            });

    final result = await sut.signInWithEmailAndPassword(params);

    expect(result.fold(id, id), isA<AccountEntity>());
  });

  test(
      'Authenticate With Email And Password: Should throw AuthException if credentials is invalid',
      () async {
    when(() => accountDatasource.signInWithEmailAndPassword(params))
        .thenThrow(InvalidCredentialException());

    final result = await sut.signInWithEmailAndPassword(params);

    expect(result.fold(id, id), isA<AuthException>());
  });

  //Authenticate With Google Tests
  test('Authenticate With Google: Should return an AccountEntity if success',
      () async {
    when(() => accountDatasource.signInWithGoogle()).thenAnswer((_) async => {
          'id': '1',
          'name': 'test',
          'email': 'testando@testando.com',
        });

    final result = await sut.signInWithGoogle();

    expect(result.fold(id, id), isA<AccountEntity>());
  });

  test(
      'Authenticate With Google: Should throw AuthException if throw exception',
      () async {
    when(() => accountDatasource.signInWithGoogle())
        .thenThrow(AuthException(message: 'Error ao entrar com google'));

    final result = await sut.signInWithGoogle();

    expect(result.fold(id, id), isA<AuthException>());
  });

  //Authenticate With Apple Tests
  test('Authenticate With Google: Should return an AccountEntity if success',
      () async {
    when(() => accountDatasource.signInWithApple()).thenAnswer((_) async => {
          'id': '1',
          'name': 'test',
          'email': 'testando@testando.com',
        });

    final result = await sut.signInWithApple();

    expect(result.fold(id, id), isA<AccountEntity>());
  });

  test(
      'Authenticate With Google: Should throw AuthException if throw exception',
      () async {
    when(() => accountDatasource.signInWithApple())
        .thenThrow(AuthException(message: 'Error ao entrar com google'));

    final result = await sut.signInWithApple();

    expect(result.fold(id, id), isA<AuthException>());
  });
}
