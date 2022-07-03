import 'event_entity.dart';
import 'member_entity.dart';

class GroupEntity {
  final String name;
  final DateTime date;
  final double value;
  final String? imageUrl;
  final EventEntity event;
  final MemberEntity owner;
  final List<MemberEntity> members;

  GroupEntity({
    required this.name,
    required this.date,
    required this.value,
    required this.event,
    required this.owner,
    required this.members,
    this.imageUrl,
  });
}
