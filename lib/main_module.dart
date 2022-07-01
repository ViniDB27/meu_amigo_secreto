import 'package:flutter_modular/flutter_modular.dart';

import 'src/modules/auth/auth_module.dart';

class MainModule extends Module {
  @override
  List<Bind> get binds => [];

  List<ModularRoute> get routes => [
    ModuleRoute('/', module: AuthModule()),
  ];
}