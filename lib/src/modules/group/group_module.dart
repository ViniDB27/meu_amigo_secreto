import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'controller/group_controller.dart';
import 'repository/group_repository.dart';
import 'view/group_view.dart';

class GroupModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<GroupRepository>((i) => GroupRepository(i())),
        //controller
        Bind.factory<GroupController>((i) => GroupController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ChangeNotifierProvider(
            create: (_) => Modular.get<GroupController>(),
            child: GroupView(
              groupId: args.data.toString(),
            ),
          ),
        ),
      ];
}
