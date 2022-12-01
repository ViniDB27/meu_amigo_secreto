import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'controller/edit_group_controller.dart';
import 'repository/edit_group_repository.dart';
import 'view/adit_group_view.dart';

class EditGroupModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<EditGroupRepository>((i) => EditGroupRepository(i())),
        //controller
        Bind.factory<EditGroupController>((i) => EditGroupController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => ChangeNotifierProvider(
            create: (_) => Modular.get<EditGroupController>(),
            child: EditGroupView(
              id: args.data.toString(),
            ),
          ),
        ),
      ];
}
