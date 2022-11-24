import 'firebase_modules/authentication/firebase_authentication_service.dart';
import 'firebase_modules/group/firebase_group_service.dart';
import 'firebase_service_exception.dart';

class FirebaseService {
  final FirebaseAuthenticationService firebaseAuthenticationService;
  final FirebaseGroupService firebaseGroupService;

  FirebaseService({
    required this.firebaseAuthenticationService,
    required this.firebaseGroupService,
  });

  //Firebase Authentication Services
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      return firebaseAuthenticationService.getCurrentUser();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> signOut({required String email}) async {
    try {
      return firebaseAuthenticationService.signOut();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      return firebaseAuthenticationService.forgotPassword(email: email);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> createNewAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return firebaseAuthenticationService.createNewAccount(
        name: name,
        email: email,
        password: password,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return firebaseAuthenticationService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      return firebaseAuthenticationService.signInWithGoogle();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> signInWithApple() async {
    try {
      return firebaseAuthenticationService.signInWithApple();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  //Firebase Groups Services
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
      return firebaseGroupService.createNewGroup(
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

  Future<List<Map<String, dynamic>>> getMyGroups() async {
    try {
      return firebaseGroupService.getMyGroups();
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGroupById(String id) async {
    try {
      return firebaseGroupService.getGroupById(id);
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
      return firebaseGroupService.editGroup(
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

  Future<void> joinGroup(String id) async {
    try {
      return firebaseGroupService.joinGroup(id);
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> saveMySuggestions({
    required String id,
    required List<String> suggestions,
  }) async {
    try {
      return firebaseGroupService.saveMySuggestions(
        id: id,
        suggestions: suggestions,
      );
    } on FirebaseServiceException {
      rethrow;
    }
  }

  Future<void> sortedFriends(String id) async {
    try {
      return firebaseGroupService.sortedFriends(id);
    } on FirebaseServiceException {
      rethrow;
    }
  }
}
