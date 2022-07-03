import 'package:dartz/dartz.dart';

import '../entities/group_entity.dart';
import '../errors/group_errors.dart';

abstract class GroupRepository {
  Stream<Either<GroupException, List<GroupEntity>>>  getGroups();
}
