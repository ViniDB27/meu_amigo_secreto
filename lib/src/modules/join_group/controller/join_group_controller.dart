import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/group_model.dart';
import '../repository/join_group_repository.dart';

class JoinGroupController {
  final JoinGroupRepository repository;

  JoinGroupController(this.repository);

  Future<GroupModel> getGroupById({
    required String id,
  }) async {
    try {
      return repository.getGroupById(id: id);
    } on FirebaseServiceException {
      rethrow;
    }
  }

   Future<void> joinGroup({
    required String id,
  }) async {
    try {
      await repository.joinGroup(id: id);
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
