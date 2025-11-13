import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/entities/user_entity.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    // 🔹 تسجيل الدخول بالبريد الإلكتروني
    on<AuthWithEmailRequested>(_onAuthWithEmailRequested);

    // 🔹 تسجيل الدخول عبر Google
    on<AuthWithGoogleRequested>(_onAuthWithGoogleRequested);

    // 🔹 تسجيل الدخول عبر Apple
    on<AuthWithAppleRequested>(_onAuthWithAppleRequested);

    // 🔹 تسجيل الدخول عبر Facebook
    on<AuthWithFacebookRequested>(_onAuthWithFacebookRequested);
  }

  Future<void> _onAuthWithEmailRequested(
      AuthWithEmailRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final UserEntity user =
      await repository.signInWithEmail(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthWithGoogleRequested(
      AuthWithGoogleRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await repository.signInWithGoogle();
      emit(AuthSuccess(null)); // null لأننا لسا ما منسترجع user فعلي من Google
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthWithAppleRequested(
      AuthWithAppleRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await repository.signInWithApple();
      emit(AuthSuccess(null));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthWithFacebookRequested(
      AuthWithFacebookRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await repository.signInWithApple();
      emit(AuthSuccess(null));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}