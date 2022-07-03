import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_apple.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/usecases/authenticate_with_apple_firebase.dart';

class AuthRepositorySpy extends Mock implements AuthRepository {}

void main() {
  late AuthRepository repository;
  late AuthenticateWithApple sut;

  setUp(() {
    repository = AuthRepositorySpy();
    sut = AuthenticateWithAppleImpl(repository);
  });

  test('Should return an AccountEntity if success', () async {
    when(() => repository.signInWithApple())
        .thenAnswer((_) async => right(AccountEntity(
              id: '1',
              name: 'test',
              email: 'testando@testando.com',
            )));

    final result = await sut();

    expect(result.fold(id, id), isA<AccountEntity>());
  });
}
