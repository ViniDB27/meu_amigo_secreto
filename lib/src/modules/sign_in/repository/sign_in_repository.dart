import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';

class SignInRepository {
  final FirebaseService firebaseService;

  SignInRepository(this.firebaseService);

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await firebaseService.signInWithGoogle();
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
