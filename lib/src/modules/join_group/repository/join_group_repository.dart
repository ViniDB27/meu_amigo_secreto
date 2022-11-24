import '../../../core/services/firebase/firebase_service.dart';
import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/group_model.dart';

class JoinGroupRepository {
  final FirebaseService firebaseService;

  JoinGroupRepository(this.firebaseService);

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

  Future<void> joinGroup({
    required String id,
  }) async {
    try {
      await firebaseService.joinGroup(id);
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
