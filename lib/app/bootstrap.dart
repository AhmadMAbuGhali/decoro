import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';



import 'bloc_observer.dart';
import 'di.dart';

Future<void> bootstrap() async {
  // Setup dependency injection
  await initDependencies();

  // Setup Bloc observer
  Bloc.observer = AppBlocObserver();

  // Initialize other services (logging, crashlytics, etc.)
  // Example placeholder
  debugPrint("Bootstrap complete");
}