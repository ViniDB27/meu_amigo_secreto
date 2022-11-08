class OwnerModel {
  final String id;
  final String name;
  final String email;

  OwnerModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(
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
