import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/errors.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/usecases/authenticate_with_email_and_password_impl.dart';

class AuthRepositorySpy extends Mock implements IAuthRepository {}

void main() {
  late IAuthRepository repository;
  late IAuthenticateWithEmailAndPassword sut;

  AuthenticateWithEmailAndPasswordParams params({
    String email = 'testando@testando.com',
    String password = '123456',
  }) =>
      AuthenticateWithEmailAndPasswordParams(email: email, password: password);

  setUp(() {
    repository = AuthRepositorySpy();
    sut = AuthenticateWithEmailAndPassword(repository: repository);
  });

  test('Should return an AccountEntity if success', () async {
    final repository = AuthRepositorySpy();
    final sut = AuthenticateWithEmailAndPassword(repository: repository);
    final params = AuthenticateWithEmailAndPasswordParams(
      email: 'testando@testando.com',
      password: '123456',
    );

    when(() => repository.login(params: params))
        .thenAnswer((_) async => right(AccountEntity(
              id: '1',
              name: 'Test Success',
              token: '123456',
            )));

    final result = await sut(params: params);

    expect(result.fold(id, id), isA<AccountEntity>());
  });

  test('Should throw AuthException if email is invalid', () async {
    final result = await sut(params: params(email: ''));

    expect(result.fold(id, id), isA<AuthException>());
  });

  test('Should throw AuthException if password is invalid', () async {
    final result = await sut(params: params(password: ''));

    expect(result.fold(id, id), isA<AuthException>());
  });
}
