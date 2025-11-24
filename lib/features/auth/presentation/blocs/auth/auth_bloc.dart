import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';
import '../../../../../core/services/session/session_manager.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  final SessionManager session;

  AuthBloc({
    required this.repository,
    required this.session,
  }) : super(AuthInitial()) {
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  // ================================
  // 🔵 Check Auth On App Start
  // ================================
  Future<void> _onCheckStatus(
      AuthCheckStatus event, Emitter<AuthState> emit) async {
    emit(AuthChecking());

    /// 1) Check access token exists
    final access = await session.getAccessToken();
    if (access == null || access.isEmpty) {
      emit(AuthUnauthenticated());
      return;
    }

    /// 2) Load user from local storage (fast)
    final user = await repository.me();
    if (user == null) {
      emit(AuthUnauthenticated());
      return;
    }

    emit(AuthAuthenticated(user));
  }

  // ================================
  // 🔵 Login
  // ================================
  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final UserEntity user =
      await repository.login(event.email, event.password);

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // ================================
  // 🔵 Register
  // ================================
  Future<void> _onRegisterRequested(
      AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final UserEntity user = await repository.register(
        event.name,
        event.email,
        event.password,
      );

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // ================================
  // 🔵 Logout
  // ================================
  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await repository.logout();
    emit(AuthUnauthenticated());
  }
}