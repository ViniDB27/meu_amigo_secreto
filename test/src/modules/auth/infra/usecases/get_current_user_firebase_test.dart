import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/get_current_user.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/repositories/auth_repository.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/entities/account_entity.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/usecases/get_current_user_firebase.dart';

class AuthRepositorySpy extends Mock implements AuthRepository {}

void main() {
  late AuthRepository repository;
  late GetCurrentUser sut;

  setUp(() {
    repository = AuthRepositorySpy();
    sut = GetCurrentUserImpl(repository);
  });

  test('Should return an AccountEntity if success', () async {
    when(() => repository.getCurrentUser())
        .thenAnswer((_) async => right(AccountEntity(
              id: '1',
              name: 'test',
              email: 'testando@testando.com',
            )));

    final result = await sut();

    expect(result.fold(id, id), isA<AccountEntity>());
  });
}
