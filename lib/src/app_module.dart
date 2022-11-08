import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/services/firebase/firebase_service.dart';
import 'core/shared/routes/app_routes.dart';
import 'modules/create_group/create_group_module.dart';
import 'modules/forgot_password/forgot_password_module.dart';
import 'modules/group/group_module.dart';
import 'modules/home/home_module.dart';
import 'modules/sign_in/sign_in_module.dart';
import 'modules/sign_up/sign_up_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        //instance
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance),

        //services
        Bind.factory<FirebaseService>(
          (i) => FirebaseService(
            firebaseAuth: i(),
            firebaseFirestore: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(AppRoutes.splash, module: SplashModule()),
        ModuleRoute(AppRoutes.signIn, module: SignInModule()),
        ModuleRoute(AppRoutes.signUp, module: SignUpModule()),
        ModuleRoute(AppRoutes.forgotPassword, module: ForgotPasswordModule()),
        ModuleRoute(AppRoutes.home, module: HomeModule()),
        ModuleRoute(AppRoutes.createGroup, module: CreateGroupModule()),
        ModuleRoute(AppRoutes.group, module: GroupModule()),
      ];
}
