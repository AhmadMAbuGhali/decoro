import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/route_path.dart';
import '../../data/repositories/onboarding_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final OnboardingRepository repo;

  SplashBloc(this.repo) : super(SplashInitial()) {
    on<SplashStarted>(_onStarted, transformer: sequential());
  }

  Future<void> _onStarted(
      SplashStarted event, Emitter<SplashState> emit) async {

    emit(SplashLoading());

    await Future.delayed(const Duration(milliseconds: 800));

    await repo.debugPrintValue();

    final isFirst = await repo.isFirstRun();

    if (isFirst) {
      emit(SplashNavigate(RoutePaths.onboarding));
    } else {
      emit(SplashNavigate(RoutePaths.authCheck));
    }
  }
}