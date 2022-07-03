import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:meu_amigo_secreto/src/modules/group/domain/entities/event_entity.dart';
import 'package:meu_amigo_secreto/src/modules/group/domain/entities/group_entity.dart';
import 'package:meu_amigo_secreto/src/modules/group/domain/entities/location_entity.dart';
import 'package:meu_amigo_secreto/src/modules/group/domain/entities/member_entity.dart';
import 'package:meu_amigo_secreto/src/modules/group/domain/repositories/group_repository.dart';
import 'package:meu_amigo_secreto/src/modules/group/domain/usecases/get_groups.dart';
import 'package:meu_amigo_secreto/src/modules/group/infra/usecases/get_groups.dart';

class GroupRepositorySpy extends Mock implements GroupRepository {}

void main() {
  late GroupRepository groupRepository;
  late GetGroups sut;

  setUp(() {
    groupRepository = GroupRepositorySpy();
    sut = GetGroupsImpl(groupRepository);
  });

  test('Should return an GroupEntity if success', () async {
//     when(() => groupRepository.getGroups()).thenAnswer((_) => right(
//           GroupEntity(
//             name: 'name',
//             date: DateTime.now(),
//             value: 50.0,
//             event: EventEntity(
//               date: DateTime.now(),
//               time: DateTime.now(),
//               street: 'street',
//               number: '23',
//               neighborhood: 'neighborhood',
//               city: 'city',
//               state: 'state',
//               zipCode: 'zipCode',
//               location: LocationEntity(
//                 longitude: '123132132',
//                 latitude: '123132132',
//               ),
//             ),
//             owner: MemberEntity(
//               name: 'name',
//               email: 'email',
//             ),
//             members: [
//               MemberEntity(
//                 name: 'name',
//                 email: 'email',
//               )
//             ],
//           ),
//         ));
  });
}
