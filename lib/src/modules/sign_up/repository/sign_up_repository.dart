import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';

class SignUpRepository {
  final FirebaseService firebaseService;

  SignUpRepository(this.firebaseService);

  Future<void> createNewAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await firebaseService.createNewAccount(
        name: name,
        email: email,
        password: password,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
