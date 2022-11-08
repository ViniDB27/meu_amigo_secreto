import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';

class ForgotPasswordRepository {
  final FirebaseService firebaseService;

  ForgotPasswordRepository(this.firebaseService);

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      await firebaseService.forgotPassword(
        email: email,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
