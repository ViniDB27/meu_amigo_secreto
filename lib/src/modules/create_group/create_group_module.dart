import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'controller/create_group_controller.dart';
import 'repository/create_group_repository.dart';
import 'view/create_group_view.dart';

class CreateGroupModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<CreateGroupRepository>((i) => CreateGroupRepository(i())),
        //controller
        Bind.factory<CreateGroupController>((i) => CreateGroupController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ChangeNotifierProvider(
            create: (_) => Modular.get<CreateGroupController>(),
            child: const CreateGroupView(),
          ),
        ),
      ];
}
