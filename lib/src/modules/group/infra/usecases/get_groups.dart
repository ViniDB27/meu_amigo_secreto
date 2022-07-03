import 'package:dartz/dartz.dart';

import '../../domain/entities/group_entity.dart';
import '../../domain/errors/group_errors.dart';
import '../../domain/usecases/get_groups.dart';
import '../../domain/repositories/group_repository.dart';

class GetGroupsImpl extends GetGroups {
  final GroupRepository groupRepository;

  GetGroupsImpl(this.groupRepository);

  @override
  Stream<Either<GroupException, List<GroupEntity>>> call() {
    return groupRepository.getGroups();
  }
}
