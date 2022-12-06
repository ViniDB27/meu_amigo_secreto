import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/services/firebase/firebase_modules/authentication/firebase_authentication_service.dart';
import 'core/services/firebase/firebase_modules/group/firebase_group_service.dart';
import 'core/services/firebase/firebase_service.dart';
import 'core/shared/guards/auth_guard.dart';
import 'core/shared/routes/app_routes.dart';
import 'modules/create_group/create_group_module.dart';
import 'modules/edit_group/edit_group_module.dart';
import 'modules/forgot_password/forgot_password_module.dart';
import 'modules/group/group_module.dart';
import 'modules/home/home_module.dart';
import 'modules/join_group/join_group_module.dart';
import 'modules/sign_in/sign_in_module.dart';
import 'modules/sign_up/sign_up_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        //instance
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance),
        Bind.instance<GoogleSignIn>(GoogleSignIn()),
        Bind.instance<FirebaseDynamicLinks>(FirebaseDynamicLinks.instance),

        //services
        Bind.factory<FirebaseAuthenticationService>(
          (i) => FirebaseAuthenticationService(
            firebaseAuth: i(),
            firebaseFirestore: i(),
            googleSignIn: i(),
          ),
        ),
        Bind.factory<FirebaseGroupService>(
          (i) => FirebaseGroupService(
            firebaseFirestore: i(),
            firebaseAuthenticationService: i(),
          ),
        ),
        Bind.factory<FirebaseService>(
          (i) => FirebaseService(
            firebaseAuthenticationService: i(),
            firebaseGroupService: i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        //Public Routes
        ModuleRoute(
          AppRoutes.splash,
          module: SplashModule(),
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          AppRoutes.signIn,
          module: SignInModule(),
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          AppRoutes.signUp,
          module: SignUpModule(),
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          AppRoutes.forgotPassword,
          module: ForgotPasswordModule(),
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),

        //Private Routes
        ModuleRoute(
          AppRoutes.home,
          module: HomeModule(),
          guards: [AuthGuard()],
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          AppRoutes.createGroup,
          module: CreateGroupModule(),
          guards: [AuthGuard()],
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          AppRoutes.editGroup,
          module: EditGroupModule(),
          guards: [AuthGuard()],
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          AppRoutes.group,
          module: GroupModule(),
          guards: [AuthGuard()],
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          AppRoutes.joinGroup,
          module: JoinGroupModule(),
          guards: [AuthGuard()],
          transition: TransitionType.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500),
        ),
      ];
}
