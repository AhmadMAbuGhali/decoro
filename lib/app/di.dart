import 'package:get_it/get_it.dart';

// Core
import '../core/services/network/api_client.dart';
import '../core/services/storage/local_storage_service.dart';
import '../core/services/storage/secure_storage_service.dart';
import '../core/services/notification/notification_service.dart';
import '../core/services/session/session_manager.dart';
import '../core/services/network/dio_client.dart';
import '../core/services/network/auth_interceptor.dart';

// Auth
import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';

// Products
import '../features/product/data/datasources/product_remote_data_source.dart';
import '../features/product/data/repositories/product_repository_impl.dart';
import '../features/product/domain/repositories/product_repository.dart';

// Search
import '../features/search/data/datasources/search_local_data_source.dart';
import '../features/search/data/datasources/search_remote_data_source.dart';
import '../features/search/data/repositories/search_repository_impl.dart';
import '../features/search/domin/repositories/search_repository.dart';

// Onboarding
import '../features/splash_onboarding/data/datasources/onboarding_local_data_source.dart';
import '../features/splash_onboarding/data/repositories/onboarding_repository_impl.dart';
import '../features/splash_onboarding/data/repositories/onboarding_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // -------------------------
  // CORE SERVICES
  // -------------------------
  sl.registerLazySingleton<ApiClient>(
        () => ApiClient(baseUrl: "http://localhost:3000/api"),
  );

  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());

  // Session Manager
  sl.registerLazySingleton<SessionManager>(() => SessionManager(
    secure: sl<SecureStorageService>(),
    local: sl<LocalStorageService>(),
  ));

  // Attach Interceptor
  final session = sl<SessionManager>();
  DioClient.dio.interceptors.add(
    AuthInterceptor(sessionManager: session),
  );

  // -------------------------
  // AUTH
  // -------------------------
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(sl<ApiClient>()),
  );

  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remote: sl<AuthRemoteDataSource>(),
      session: sl<SessionManager>(),
    ),
  );

  // -------------------------
  // PRODUCTS
  // -------------------------
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSource(sl<ApiClient>()),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
  );

  // -------------------------
  // SEARCH
  // -------------------------
// Search
  sl.registerLazySingleton<SearchRemoteDataSource>(() => SearchRemoteDataSource(sl<ApiClient>()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(sl<SearchRemoteDataSource>()));

  // -------------------------
  // ONBOARDING
  // -------------------------
  sl.registerLazySingleton<OnboardingLocalDataSource>(
        () => OnboardingLocalDataSource(),
  );

  sl.registerLazySingleton<OnboardingRepository>(
        () => OnboardingRepositoryImpl(
      localDataSource: sl<OnboardingLocalDataSource>(),
    ),
  );
}