import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meu_amigo_secreto/src/core/shared/routes/app_routes.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

import 'firebase_service_exception.dart';

class FirebaseService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;
  final FirebaseDynamicLinks dynamicLinks;

  FirebaseService({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
    required this.dynamicLinks,
  });

  Future<UserCredential> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
        apiKey: '<your consumer key>',
        apiSecretKey: ' <your consumer secret>',
        redirectURI: '<your_scheme>://');

    final authResult = await twitterLogin.login();

    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      final firebaseAccount = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      final CollectionReference userCollection =
          firebaseFirestore.collection('users');

      final users = await userCollection
          .where('uid', isEqualTo: firebaseAccount.user?.uid)
          .get();

      if (users.docs.isEmpty) {
        await userCollection.add({
          'name': firebaseAccount.user!.displayName,
          'email': firebaseAccount.user!.email,
          'uid': firebaseAccount.user!.uid,
          'avatar': firebaseAccount.user!.photoURL,
          'phone': firebaseAccount.user!.phoneNumber,
        });
      }
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      final firebaseAccount =
          await firebaseAuth.signInWithCredential(oauthCredential);

      final CollectionReference userCollection =
          firebaseFirestore.collection('users');

      final users = await userCollection
          .where('uid', isEqualTo: firebaseAccount.user?.uid)
          .get();

      if (users.docs.isEmpty) {
        await userCollection.add({
          'name': firebaseAccount.user!.displayName,
          'email': firebaseAccount.user!.email,
          'uid': firebaseAccount.user!.uid,
          'avatar': firebaseAccount.user!.photoURL,
          'phone': firebaseAccount.user!.phoneNumber,
        });
      }
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final firebaseAccount =
          await firebaseAuth.signInWithCredential(credential);

      final CollectionReference userCollection =
          firebaseFirestore.collection('users');

      final users = await userCollection
          .where('uid', isEqualTo: firebaseAccount.user?.uid)
          .get();

      if (users.docs.isEmpty) {
        await userCollection.add({
          'name': firebaseAccount.user!.displayName,
          'email': firebaseAccount.user!.email,
          'uid': firebaseAccount.user!.uid,
          'avatar': firebaseAccount.user!.photoURL,
          'phone': firebaseAccount.user!.phoneNumber,
        });
      }
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> createNewAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final firebaseAccount = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final CollectionReference users = firebaseFirestore.collection('users');

      await users.add({
        'name': name,
        'email': email,
        'uid': firebaseAccount.user!.uid,
        'avatar': null,
        'phone': null,
      });
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseAccount = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final users = await firebaseFirestore
          .collection('users')
          .where('uid', isEqualTo: firebaseAccount.user?.uid)
          .get();

      final user = users.docs.first;

      return {
        "id": user['uid'],
        "name": user['uid'],
        "email": user['uid'],
        'avatar': user['avatar'],
        'phone': user['phone'],
      };
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final account = firebaseAuth.currentUser;

      if (account == null) {
        return null;
      }

      final users = await firebaseFirestore
          .collection('users')
          .where('uid', isEqualTo: account.uid)
          .get();

      if (users.docs.isEmpty) {
        return null;
      }

      final user = users.docs.first;

      return {
        'id': user['uid'],
        'name': user['name'],
        'email': user['email'],
        'avatar': user['avatar'],
        'phone': user['phone'],
      };
    } on FirebaseException catch (error) {
      throw FirebaseServiceException(error.code);
    }
  }

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
      final user = await getCurrentUser();

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
      final user = await getCurrentUser();

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

  Future<Map<String, dynamic>> getGroupById({
    required String id,
  }) async {
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

  Future<void> joinGroup({
    required String id,
  }) async {
    try {
      final user = await getCurrentUser();

      if (user != null) {
        final group =
            await firebaseFirestore.collection('groups').doc(id).get();
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
      final user = await getCurrentUser();

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

  Future<void> sortedFriends({
    required String id,
  }) async {
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
}
