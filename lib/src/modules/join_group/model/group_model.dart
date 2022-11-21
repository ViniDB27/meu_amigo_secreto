class GroupModel {
  final String id;
  final String name;
  final String drawDate;
  final String value;
  final String eventDate;
  final String eventTime;
  final String address;
  final String neighborhood;
  final String number;
  final String city;
  final String zipCode;
  final bool isDraw;
  final String? image;

  GroupModel({
    required this.id,
    required this.name,
    required this.drawDate,
    required this.value,
    required this.eventDate,
    required this.eventTime,
    required this.address,
    required this.neighborhood,
    required this.number,
    required this.city,
    required this.zipCode,
    required this.isDraw,
    this.image,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      drawDate: map['drawDate'],
      value: map['value'],
      eventDate: map['eventDate'],
      eventTime: map['eventTime'],
      address: map['address'],
      neighborhood: map['neighborhood'],
      number: map['number'],
      city: map['city'],
      zipCode: map['zipCode'],
      isDraw: map['isDraw'],
    );
  }

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'image': image,
        'drawDate': drawDate,
        'value': value,
        'eventDate': eventDate,
        'eventTime': eventTime,
        'address': address,
        'neighborhood': neighborhood,
        'number': number,
        'city': city,
        'zipCode': zipCode,
        'isDraw': isDraw,
      };
}
