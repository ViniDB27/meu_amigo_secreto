import 'package:flutter_modular/flutter_modular.dart';

import 'view/join_group_view.dart';



class JoinGroupModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        // Bind.factory<HomeRepository>((i) => HomeRepository(i())),
        //controller
        // Bind.factory<HomeController>((i) => HomeController(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const JoinGroupView()),
      ];
}
