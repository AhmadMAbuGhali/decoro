import 'package:get_it/get_it.dart';

import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/splash_onboarding/data/datasources/onboarding_local_data_source.dart';
import '../features/splash_onboarding/data/repositories/onboarding_repository.dart';
import '../features/splash_onboarding/data/repositories/onboarding_repository_impl.dart';


final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Local data source
  sl.registerLazySingleton<OnboardingLocalDataSource>(
        () => OnboardingLocalDataSource(),
  );

  // Repository as interface
  sl.registerLazySingleton<OnboardingRepository>(
        () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  // ... register other services
}