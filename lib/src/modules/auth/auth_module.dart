import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'domain/usecases/authenticate_with_email_and_password.dart';
import 'domain/repositories/auth_repository.dart';

import 'infra/usecases/authenticate_with_email_and_password_firebase.dart';
import 'infra/repositories/auth_repository_firebase_impl.dart';
import 'infra/datasources/account_datasource.dart';

import 'external/datasources/account_datasource_firebase_impl.dart';

import 'presenter/blocs/authenticate_with_email_and_password_bloc.dart';
import 'presenter/pages/signin/signin_page.dart';
import 'presenter/pages/splash/splash_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        //utils
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.instance<GoogleSignIn>(GoogleSignIn()),
        //datasources
        Bind.factory<AccountDatasource>((i) => AccountDatasourceFirebaseImpl(
              firebaseAuth: i(),
              googleSignIn: i(),
            )),
        //repositories
        Bind.factory<AuthRepository>((i) => AuthRepositoryFirebaseImpl(i())),
        //usecases
        Bind.factory<AuthenticateWithEmailAndPassword>(
            (i) => AuthenticateWithEmailAndPasswordImpl(i())),
        //blocs
        Bind.singleton<AuthenticateWithEmailAndPasswordBloc>(
            (i) => AuthenticateWithEmailAndPasswordBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SignInPage()),
        ChildRoute('/splash', child: (context, args) => const SplashPage()),
      ];
}
