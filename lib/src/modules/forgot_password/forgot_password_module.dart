import 'package:flutter_modular/flutter_modular.dart';

import 'controller/forgot_password_controller.dart';
import 'repository/forgot_password_repository.dart';
import 'view/forgot_password_view.dart';

class ForgotPasswordModule extends Module {
  @override
  List<Bind> get binds => [
        //repository
        Bind.factory<ForgotPasswordRepository>(
          (i) => ForgotPasswordRepository(i()),
        ),
        //controller
        Bind.factory<ForgotPasswordController>(
          (i) => ForgotPasswordController(i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ForgotPasswordView()),
      ];
}
