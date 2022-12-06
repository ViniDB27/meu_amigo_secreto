import 'package:flutter_modular/flutter_modular.dart';

import '../../services/firebase/firebase_modules/authentication/firebase_authentication_service.dart';
import '../routes/app_routes.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: AppRoutes.signIn);

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    final firebaseAuth = Modular.get<FirebaseAuthenticationService>();

    try {
      final user = await firebaseAuth.getCurrentUser();

      if (user != null) {
        return true;
      }

      return false;
    } on Exception {
      return false;
    }
  }
}
