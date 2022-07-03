import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'src/modules/group/group_module.dart';
import 'src/modules/auth/auth_module.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance),
    ...AuthModule.exports,

  ];

  List<ModularRoute> get routes => [
    ModuleRoute('/', module: AuthModule()),
    ModuleRoute('/group', module: GroupModule()),
  ];
}