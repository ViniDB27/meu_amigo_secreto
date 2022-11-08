import '../../../core/services/firebase/firebase_service_exception.dart';
import '../model/friend_model.dart';
import '../model/group_model.dart';
import '../repository/group_repository.dart';

class GroupController {
  final GroupRepository repository;

  GroupController(this.repository);

  Future<GroupModel> getGroupById({
    required String id,
  }) async {
    try {
      return repository.getGroupById(id: id);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<bool> isOwnerGroup({
    required String id,
  }) async {
    try {
      return repository.isOwnerGroup(id: id);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<FriendModel?> myFriend({
    required String id,
  }) async {
    try {
      return repository.myFriend(id: id);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<List<dynamic>> getMySuggestions({
    required String id,
  }) async {
    try {
      return repository.getMySuggestions(id: id);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> saveMySuggestions({
    required String id,
    required List<String> suggestions,
  }) async {
    try {
      await repository.saveMySuggestions(
        id: id,
        suggestions: suggestions,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> sortedFriends({
    required String id,
  }) async {
    try {
      await repository.sortedFriends(
        id: id,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<List<dynamic>> getSuggestionsMyFriend({
    required String groupId,
    required String friendId,
  }) async {
    try {
      return repository.getSuggestionsMyFriend(
        groupId: groupId,
        friendId: friendId,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
