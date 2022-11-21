import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';

class SplashRepository {
  final FirebaseService firebaseService;

  SplashRepository(this.firebaseService);

  Future<bool> userIsLogged() async {
    try {
      final user = await firebaseService.getCurrentUser();

      if (user != null) {
        return true;
      }

      return false;
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
