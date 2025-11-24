import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'di.dart';

Future<void> bootstrap() async {
  // Ensure binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 1) Setup Dependency Injection
    await initDependencies();

    // 2) Setup Bloc Global Observer
    Bloc.observer = AppBlocObserver();

    // 3) Initialize other core services (logging, analytics, crash reporters...etc)
    // Example:
    // await LoggerService.init();
    // await CrashlyticsService.init();

    debugPrint("🚀 Bootstrap completed successfully");
  } catch (e, st) {
    debugPrint("❌ Bootstrap failed: $e\n$st");

    // يمكنك عمل rethrow إذا بدك توقف التطبيق
    // rethrow;
  }
}