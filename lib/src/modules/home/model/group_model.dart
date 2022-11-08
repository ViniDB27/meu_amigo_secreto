class GroupModel {
  final String id;
  final String name;
  final String date;
  final int members;
  final String? image;

  GroupModel({
    required this.id,
    required this.name,
    required this.date,
    required this.members,
    this.image,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      date: map['date'],
      members: map['members'],
    );
  }

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'image': image,
        'date': date,
        'members': members,
      };
}
