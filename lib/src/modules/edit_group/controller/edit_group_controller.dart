import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/group_model.dart';
import '../repository/edit_group_repository.dart';

class EditGroupController {
  final EditGroupRepository repository;

  EditGroupController(this.repository);

  Future<GroupModel> getGroupById({
    required String id,
  }) async {
    try {
      return repository.getGroupById(id: id);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> editGroup({
    required String id,
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
      await repository.editGroup(
        id: id,
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
