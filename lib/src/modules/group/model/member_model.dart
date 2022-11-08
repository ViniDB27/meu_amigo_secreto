import 'friend_model.dart';

class MemberModel {
  final String id;
  final String name;
  final String email;
  final List<dynamic> suggestions;
  final FriendModel? friend;

  MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.suggestions,
    this.friend,
  });

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      suggestions: map['suggestions'],
      friend:
          map['friend'] != null ? FriendModel.fromMap(map['friend']) : null,
    );
  }

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'email': email,
        'suggestions': suggestions,
        'friend': friend?.toMap,
      };
}
