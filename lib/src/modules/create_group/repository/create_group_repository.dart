import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';

class CreateGroupRepository {
  final FirebaseService firebaseService;

  CreateGroupRepository(this.firebaseService);

  Future<void> createNewGroup({
    required String name,
    required String drawDate,
    required String value,
    required String eventDate,
    required String eventTime,
    required String address,
    required String neighborhood,
    required String number,
    required String city,
    required String zipCode,
    String? image,
  }) async {
    try {
      await firebaseService.createNewGroup(
        name: name,
        drawDate: drawDate,
        value: value,
        eventDate: eventDate,
        eventTime: eventTime,
        address: address,
        neighborhood: neighborhood,
        number: number,
        city: city,
        zipCode: zipCode,
        image: image,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
