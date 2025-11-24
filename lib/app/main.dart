import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';
import 'bootstrap.dart';
import 'env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🟡 Optional: Change environment here
  // AppEnv.setEnvironment(Environment.staging);

  // 🔥 Run app in protected zone
  await runZonedGuarded(() async {
    await bootstrap(); // DI, services, logging...
    runApp(const App());
  }, (error, stack) {
    // Global unexpected error logging
    debugPrint("🔥 Uncaught Error: $error");
  });
}