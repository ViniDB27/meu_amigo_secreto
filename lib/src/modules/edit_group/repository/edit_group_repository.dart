import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/group_model.dart';

class EditGroupRepository {
  final FirebaseService firebaseService;

  EditGroupRepository(this.firebaseService);

  Future<GroupModel> getGroupById({
    required String id,
  }) async {
    try {
      final groupMap = await firebaseService.getGroupById(id);

      return GroupModel.fromMap(groupMap);
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
      await firebaseService.editGroup(
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

  Future<void> deleteGroup(String id) async {
    try {
      await firebaseService.deleteGroup(id);
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
