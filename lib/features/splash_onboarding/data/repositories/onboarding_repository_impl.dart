import 'package:decoro/features/splash_onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:decoro/features/splash_onboarding/data/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {

  final OnboardingLocalDataSource localDataSource;
  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<void> completeOnboarding() {
    // TODO: implement completeOnboarding
    return localDataSource.setFirstRunFalse();
  }

  @override
  Future<bool> isFirstRun() {
    // TODO: implement isFirstRun
   return localDataSource.isFirstRun();
  }

}
