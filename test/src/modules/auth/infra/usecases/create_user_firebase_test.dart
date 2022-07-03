import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/create_user.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/auth_errors.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/usecases/create_user_firebase.dart';

class AuthRepositorySpy extends Mock implements AuthRepository {}

void main() {
  late AuthRepository repository;
  late CreateUser sut;
  late CreateUserCredentials credentials;

  CreateUserCredentials mockCredentials({
    String name = 'test',
    String email = 'testando@testando.com',
    String password = '123456',
  }) =>
      CreateUserCredentials(
        name: name,
        email: email,
        password: password,
      );

    setUp(() {
    repository = AuthRepositorySpy();
    sut = CreateUserImpl(repository);
    credentials = mockCredentials();
  });

  test('Should return an AccountEntity if success', () async {
  
    when(() => repository.createUser(credentials))
        .thenAnswer((_) async => right(AccountEntity(
              id: '1',
              name: 'test',
              email: 'testando@testando.com',
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
 
  test('Should throw AuthException if name is invalid', () async {
    final result = await sut(mockCredentials(name: ''));

    expect(result.fold(id, id), isA<AuthException>());
  });
}
