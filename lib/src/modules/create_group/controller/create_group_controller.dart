import '../../../core/services/firebase/firebase_service_exception.dart';
import '../repository/create_group_repository.dart';

class CreateGroupController {
  final CreateGroupRepository repository;

  CreateGroupController(this.repository);

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
      await repository.createNewGroup(
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

  String? fieldIsNotEmptyValidator(String value) {
    if (value.isEmpty) {
      return 'O campo não pode ser vazio';
    }
    return null;
  }
}
