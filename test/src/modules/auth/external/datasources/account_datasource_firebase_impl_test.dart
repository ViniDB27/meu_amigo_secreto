import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/auth_errors.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/datasources/account_datasource.dart';

import 'package:meu_amigo_secreto/src/modules/auth/external/datasources/account_datasource_firebase_impl.dart';

class FirebaseAuthSpy extends Mock implements FirebaseAuth {}

void main() {
  late AuthenticateWithEmailAndPasswordCredentials params;
  late FirebaseAuth firebaseAuth;
  late AccountDatasource sut;
  late MockUser user;
  late MockFirebaseAuth authMock;
  late UserCredential userCredentialMock;

  setUp(() async {
    firebaseAuth = FirebaseAuthSpy();
    sut = AccountDatasourceFirebaseImpl(firebaseAuth);
    params = AuthenticateWithEmailAndPasswordCredentials(
      email: 'testando@testando.com',
      password: '123456',
    );

    user = MockUser(
      isAnonymous: false,
      uid: '0790c05e-a4c5-4971-ba5c-32005e2b09a3',
      email: 'testando@testando.com',
      displayName: 'Jhon Doe',
    );

    authMock = MockFirebaseAuth(mockUser: user);

    userCredentialMock = await authMock.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  });

  test('Should return a Map if success', () async {
    when(() => firebaseAuth.signInWithEmailAndPassword(
          email: params.email,
          password: params.password,
        )).thenAnswer((_) async => userCredentialMock);

    final result = await sut.signInWithEmailAndPasswordParams(params);

    expect(result, isA<Map>());
  });

  // test('Should throw AuthException if credentials is invalid', () async {
  //    when(() => firebaseAuth.signInWithEmailAndPassword(
  //         email: params.email,
  //         password: params.password,
  //       )).thenThrow(FirebaseAuthException(code: 'invalid-credential', message: 'Invalid Credentials'));

  //   final result = sut.signInWithEmailAndPasswordParams(params);

  //   expect(result, throwsA(AuthException));
  // });
}
