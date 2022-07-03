import 'location_entity.dart';

class EventEntity {
  final DateTime date;
  final DateTime time;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String zipCode;
  final LocationEntity location;

  EventEntity({
    required this.date,
    required this.time,
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.location,
  });
}
