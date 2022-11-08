class FriendModel {
  final String id;
  final String name;
  final String email;

  FriendModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'email': email,
      };
}
