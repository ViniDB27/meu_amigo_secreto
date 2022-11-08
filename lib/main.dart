import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/core/configs/firebase/firebase_options.dart';
import 'src/app_module.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ModularApp(module: AppModule(), child: const App()));
}
