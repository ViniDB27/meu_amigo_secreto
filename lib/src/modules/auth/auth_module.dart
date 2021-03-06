import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'domain/usecases/authenticate_with_email_and_password.dart';
import 'domain/usecases/authenticate_with_google.dart';
import 'domain/usecases/authenticate_with_apple.dart';
import 'domain/usecases/get_current_user.dart';
import 'domain/usecases/recover_password.dart';
import 'domain/usecases/create_user.dart';

import 'domain/repositories/auth_repository.dart';

import 'infra/usecases/recover_password_firebase.dart';
import 'infra/usecases/authenticate_with_email_and_password_firebase.dart';
import 'infra/usecases/authenticate_with_google_firebase.dart';
import 'infra/usecases/authenticate_with_apple_firebase.dart';
import 'infra/usecases/get_current_user_firebase.dart';
import 'infra/usecases/create_user_firebase.dart';

import 'infra/repositories/auth_repository_firebase_impl.dart';

import 'infra/datasources/account_datasource.dart';

import 'external/datasources/account_datasource_firebase_impl.dart';

import 'presenter/blocs/authenticate_with_email_and_password_bloc.dart';
import 'presenter/blocs/authenticate_with_google_bloc.dart';
import 'presenter/blocs/authenticate_with_apple_bloc.dart';
import 'presenter/blocs/recover_password_bloc.dart';
import 'presenter/blocs/get_current_user_bloc.dart';
import 'presenter/blocs/create_user_bloc.dart';

import 'presenter/pages/splash/splash_page.dart';
import 'presenter/pages/signup/signup_page.dart';
import 'presenter/pages/signin/signin_page.dart';
import 'presenter/pages/recover/recover_page.dart';

class AuthModule extends Module {
  static List<Bind> get exports => [
        Bind.factory<GetCurrentUser>((i) => GetCurrentUserImpl(i())),
      ];

  @override
  List<Bind> get binds => [
        //utils
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.instance<GoogleSignIn>(GoogleSignIn()),
       
        //datasources
        Bind.factory<AccountDatasource>((i) => AccountDatasourceFirebaseImpl(
              firebaseAuth: i(),
              firebaseFirestore: i(),
              googleSignIn: i(),
            )),
        
        //repositories
        Bind.factory<AuthRepository>((i) => AuthRepositoryFirebaseImpl(i())),
       
        //usecases
        Bind.factory<AuthenticateWithEmailAndPassword>(
            (i) => AuthenticateWithEmailAndPasswordImpl(i())),
        Bind.factory<AuthenticateWithGoogle>(
            (i) => AuthenticateWithGoogleImpl(i())),
        Bind.factory<AuthenticateWithApple>(
            (i) => AuthenticateWithAppleImpl(i())),
        Bind.factory<CreateUser>((i) => CreateUserImpl(i())),
        Bind.factory<RecoverPassword>((i) => RecoverPasswordImpl(i())),
        
        //blocs
        Bind.singleton<AuthenticateWithEmailAndPasswordBloc>(
            (i) => AuthenticateWithEmailAndPasswordBloc(i())),
        Bind.singleton<AuthenticateWithGoogledBloc>(
            (i) => AuthenticateWithGoogledBloc(i())),
        Bind.singleton<AuthenticateWithAppleBloc>(
            (i) => AuthenticateWithAppleBloc(i())),
        Bind.singleton<CreateUserBloc>((i) => CreateUserBloc(i())),
        Bind.singleton<GetCurrentUserBloc>((i) => GetCurrentUserBloc(i())),
        Bind.singleton<RecoverPasswordBloc>((i) => RecoverPasswordBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ChildRoute('/signin', child: (context, args) => const SignInPage()),
        ChildRoute('/signup', child: (context, args) => const SignupPage()),
        ChildRoute('/recover', child: (context, args) => const RecoverPage()),
      ];
}
