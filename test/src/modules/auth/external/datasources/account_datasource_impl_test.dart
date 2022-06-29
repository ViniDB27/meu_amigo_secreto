import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/errors/errors.dart';

import 'package:meu_amigo_secreto/src/modules/auth/external/datasources/account_datasource_impl.dart';

class FirebaseAuthSpy extends Mock implements FirebaseAuth {}

class UserCredentialSpy extends Mock implements UserCredential {}

class AuthCredentialSpy extends Mock implements AuthCredential {}

class UserSpy extends Mock implements User {}

void main() {
  test('Should return a Map if success', () async {
    final firebaseAuth = FirebaseAuthSpy();
    final sut = AccountDatasourceFirebaseImpl(firebaseAuth: firebaseAuth);

    final userCredential = UserCredentialSpy();
    final userSpy = UserSpy();
    final authCredentialSpy = AuthCredentialSpy();

    const email = 'testando@testando.com';
    const password = '123456';

    when(() => userSpy.uid).thenAnswer((_) => '1');
    when(() => userSpy.displayName).thenAnswer((_) => 'test');
    when(() => authCredentialSpy.token).thenAnswer((_) => 12345);

    when(() => userCredential.user).thenAnswer((_) => userSpy);
    when(() => userCredential.credential).thenAnswer((_) => authCredentialSpy);

    when(() => firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenAnswer((_) async => userCredential);

    final result = await sut.login(
      email: email,
      password: password,
    );

    expect(result, isA<Map>());
  });

  // test(
  //   'Should throw AuthException if AccountDatasourceFirebaseImpl return FirebaseAuthException',
  //   () async {
  //     final firebaseAuth = FirebaseAuthSpy();
  //     final sut = AccountDatasourceFirebaseImpl(firebaseAuth: firebaseAuth);

  //     const email = 'testando@testando.com';
  //     const password = '123456';

  //     when(() => firebaseAuth.signInWithEmailAndPassword(
  //           email: email,
  //           password: password,
  //         )).thenThrow(FirebaseAuthException(
  //       code: 'credentials.invalid',
  //       message: 'invalid credentials',
  //     ));

  //     final result = sut.login(
  //       email: email,
  //       password: password,
  //     );

  //     expect(result,  throwsA(AuthException)); 
  //   },
  // );
}
