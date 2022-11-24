import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/routes/app_routes.dart';
import '../../firebase_service_exception.dart';
import '../authentication/firebase_authentication_service.dart';

class FirebaseGroupService {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuthenticationService firebaseAuthenticationService;

  FirebaseGroupService({
    required this.firebaseFirestore,
    required this.firebaseAuthenticationService,
  });

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
      final user = await firebaseAuthenticationService.getCurrentUser();

      final CollectionReference groups = firebaseFirestore.collection('groups');

      await groups.add({
        'image': image,
        'name': name,
        'drawDate': drawDate,
        'value': value,
        'eventDate': eventDate,
        'eventTime': eventTime,
        'address': address,
        'neighborhood': neighborhood,
        'number': number,
        'city': city,
        'zipCode': zipCode,
        'isDraw': false,
        'owner': {
          'id': user?['id'],
          'name': user?['name'],
          'email': user?['email'],
        },
        "members": [
          {
            'id': user?['id'],
            'name': user?['name'],
            'email': user?['email'],
            'suggestions': [],
            'friend': null,
          }
        ]
      });
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<List<Map<String, dynamic>>> getMyGroups() async {
    try {
      final user = await firebaseAuthenticationService.getCurrentUser();

      final groupsFb = await firebaseFirestore.collection('groups').get();

      final groups = groupsFb.docs.where((group) {
        final members = group['members'] as List;

        final member =
            members.where((member) => member['email'] == user?['email']);

        return member.isNotEmpty;
      }).toList();

      return groups.map((e) {
        return {
          'id': e.id,
          'image': e['image'],
          'name': e['name'],
          'drawDate': e['drawDate'],
          'value': e['value'],
          'eventDate': e['eventDate'],
          'eventTime': e['eventTime'],
          'address': e['address'],
          'neighborhood': e['neighborhood'],
          'number': e['number'],
          'city': e['city'],
          'zipCode': e['zipCode'],
          'isDraw': e['isDraw'],
          'owner': e['owner'],
          "members": e['members'],
        };
      }).toList();
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<Map<String, dynamic>> getGroupById(String id) async {
    try {
      final group = firebaseFirestore.collection('groups').doc(id);

      return group.get().then((value) {
        return {
          'id': value.id,
          'image': value['image'],
          'name': value['name'],
          'drawDate': value['drawDate'],
          'value': value['value'],
          'eventDate': value['eventDate'],
          'eventTime': value['eventTime'],
          'address': value['address'],
          'neighborhood': value['neighborhood'],
          'number': value['number'],
          'city': value['city'],
          'zipCode': value['zipCode'],
          'isDraw': value['isDraw'],
          'owner': value['owner'],
          "members": value['members'],
        };
      });
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
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
      final groups = await firebaseFirestore.collection('groups').doc(id).get();

      await groups.reference.update({
        'image': image,
        'name': name,
        'drawDate': drawDate,
        'value': value,
        'eventDate': eventDate,
        'eventTime': eventTime,
        'address': address,
        'neighborhood': neighborhood,
        'number': number,
        'city': city,
        'zipCode': zipCode,
      });
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> joinGroup(String id) async {
    try {
      final user = await firebaseAuthenticationService.getCurrentUser();

      if (user != null) {
        final group =
            await firebaseFirestore.collection('groups').doc(id).get();

        final bool isDraw = group['isDraw'] as bool;

        if (!isDraw) {
          final members = group['members'];

          final memberExists =
              members.where((member) => member['id'] == user['id']).isEmpty;

          if (memberExists) {
            await group.reference.update({
              'members': [
                ...members,
                {
                  "id": user['id'],
                  "name": user['name'],
                  "email": user['email'],
                  "suggestions": [],
                  "friend": null,
                }
              ],
            });
          }
        }
      } else {
        Modular.to.pushReplacementNamed(AppRoutes.signIn);
      }
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> saveMySuggestions({
    required String id,
    required List<String> suggestions,
  }) async {
    try {
      final user = await firebaseAuthenticationService.getCurrentUser();

      final groups = await firebaseFirestore.collection('groups').doc(id).get();

      final members = groups['members'];
      final member = members.firstWhere((mbr) => mbr['id'] == user?['id']);

      member['suggestions'] = suggestions;

      final newMembers =
          members.where((mbr) => mbr['id'] != member['id']).toList();

      await groups.reference.update({
        'members': [...newMembers, member]
      });
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> sortedFriends(String id) async {
    try {
      final groups = await firebaseFirestore.collection('groups').doc(id).get();

      List members = groups['members'];

      for (var i = 0; i < members.length; i++) {
        int indexRandom = Random().nextInt(members.length);

        var temp = members[i];
        members[i] = members[indexRandom];
        members[indexRandom] = temp;
      }

      for (var i = 0; i < members.length; i++) {
        final member = members[i];

        if (i == members.length - 1) {
          member['friend'] = {
            "id": members[0]['id'],
            "name": members[0]['name'],
            "email": members[0]['email'],
          };
        } else {
          member['friend'] = {
            "id": members[i + 1]['id'],
            "name": members[i + 1]['name'],
            "email": members[i + 1]['email'],
          };
        }
      }

      await groups.reference.update({
        'isDraw': true,
        'members': [...members],
      });
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }
}
