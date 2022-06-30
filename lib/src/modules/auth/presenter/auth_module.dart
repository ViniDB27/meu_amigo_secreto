import 'package:flutter_modular/flutter_modular.dart';


import '../infra/repositories/auth_repository_firebase_impl.dart';
import '../infra/usecases/authenticate_with_email_and_password_firebase.dart';

import '../external/datasources/account_datasource_firebase_impl.dart';

import './pages/signin_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
    //datasources
    Bind.factory((i) => AccountDatasourceFirebaseImpl(i())),
    //repositories
    Bind.factory((i) => AuthRepositoryFirebaseImpl(i())),
    //usecases
    Bind.factory((i) => AuthenticateWithEmailAndPasswordOnFirebase(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const SignInPage()),
  ];
}
