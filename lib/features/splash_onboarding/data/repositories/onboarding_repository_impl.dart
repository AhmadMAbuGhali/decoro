import '../datasources/onboarding_local_data_source.dart';
import 'onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> isFirstRun() {
    return localDataSource.isFirstRun();
  }

  @override
  Future<void> completeOnboarding() {
    return localDataSource.setFirstRunFalse();
  }

  @override
  Future<void> debugPrintValue() {
    return localDataSource.debugPrintValue();
  }
}