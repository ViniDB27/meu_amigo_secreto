import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/firebase/firebase_service_exception.dart';
import '../../../core/shared/routes/app_routes.dart';
import '../repository/splash_repository.dart';

class SplashController {
  final SplashRepository repository;

  SplashController(this.repository);

  void verifyIfExistUserLogged() async {
    if (await userIsLogged()) {
      await Modular.to.pushReplacementNamed(AppRoutes.home);
    } else {
      await Modular.to.pushReplacementNamed(AppRoutes.signIn);
    }
  }

  Future<bool> userIsLogged() async {
    try {
      return repository.userIsLogged();
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
