import 'package:flutter_modular/flutter_modular.dart';

import 'controller/join_group_controller.dart';
import 'repository/join_group_repository.dart';
import 'view/join_group_view.dart';

class JoinGroupModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<JoinGroupRepository>((i) => JoinGroupRepository(i())),
        //controller
        Bind.factory<JoinGroupController>((i) => JoinGroupController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => JoinGroupView(uri: args.uri)),
      ];
}
