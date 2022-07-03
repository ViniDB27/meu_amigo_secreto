import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/authenticate_with_email_and_password.dart';
import 'package:meu_amigo_secreto/src/modules/auth/domain/usecases/create_user.dart';

import 'package:meu_amigo_secreto/src/modules/auth/infra/datasources/account_datasource.dart';

import 'package:meu_amigo_secreto/src/modules/auth/external/datasources/account_datasource_firebase_impl.dart';

void main() {
  late AuthenticateWithEmailAndPasswordCredentials credentials;
  late CreateUserCredentials credentialsCreateUser;

  late FirebaseAuth firebaseAuth;
  late GoogleSignIn googleSignIn;

  late AccountDatasource sut;

  setUp(() async {
    firebaseAuth = MockFirebaseAuth();
    googleSignIn = MockGoogleSignIn();

    sut = AccountDatasourceFirebaseImpl(
      firebaseAuth: firebaseAuth,
      googleSignIn: googleSignIn,
    );

    credentials = AuthenticateWithEmailAndPasswordCredentials(
      email: 'testando@testando.com',
      password: '123456',
    );

    credentialsCreateUser = CreateUserCredentials(
      name: 'test',
      email: 'testando@testando.com',
      password: '123456',
    );
  });

  test('GetCurrentUser: Should return a Map if success', () async {
    final result = await sut.getCurrentUser();

    expect(result, isA<Map>());
  });

  test('CreateUser: Should return a Map if success', () async {
    final result = await sut.createUser(credentialsCreateUser);

    expect(result, isA<Map>());
  });

  test('SignInWithEmailAndPassword: Should return a Map if success', () async {
    final result = await sut.signInWithEmailAndPassword(credentials);

    expect(result, isA<Map>());
  });

  test('SignInWithGoogle: Should return a Map if success', () async {
    final result = await sut.signInWithGoogle();

    expect(result, isA<Map>());
  });

  // test('SignInWithApple: Should return a Map if success', () async {
  //   final result = await sut.signInWithApple();

  //   expect(result, isA<Map>());
  // });
}
