import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/auth_errors.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/usecases/authenticate_with_email_and_password_firebase.dart';

class AuthRepositorySpy extends Mock implements AuthRepository {}

void main() {
  late AuthRepository repository;
  late AuthenticateWithEmailAndPassword sut;

  AuthenticateWithEmailAndPasswordCredentials mockCredentials({
    String email = 'testando@testando.com',
    String password = '123456',
  }) =>
      AuthenticateWithEmailAndPasswordCredentials(
        email: email,
        password: password,
      );

  setUp(() {
    repository = AuthRepositorySpy();
    sut = AuthenticateWithEmailAndPasswordOnFirebase(repository);
  });

  test('Should return an AccountEntity if success', () async {
    final repository = AuthRepositorySpy();
    final sut = AuthenticateWithEmailAndPasswordOnFirebase(repository);
    final credentials = AuthenticateWithEmailAndPasswordCredentials(
      email: 'testando@testando.com',
      password: '123456',
    );

    when(() => repository.signInWithEmailAndPasswordParams(credentials))
        .thenAnswer((_) async => right(AccountEntity(
              id: '1',
              name: 'testando@testando.com',
              email: '123456',
            )));

    final result = await sut(credentials);

    expect(result.fold(id, id), isA<AccountEntity>());
  });

  test('Should throw AuthException if email is invalid', () async {
    final result = await sut(mockCredentials(email: ''));

    expect(result.fold(id, id), isA<AuthException>());
  });

  test('Should throw AuthException if password is invalid', () async {
    final result = await sut(mockCredentials(password: ''));

    expect(result.fold(id, id), isA<AuthException>());
  });
}
