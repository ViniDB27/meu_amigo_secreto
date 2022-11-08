import '../../../core/services/firebase/firebase_service_exception.dart';
import '../repository/splash_repository.dart';

class SplashController {
  final SplashRepository repository;

  SplashController(this.repository);

  Future<bool> userIsLogged() async {
    try {
      return repository.userIsLogged();
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
