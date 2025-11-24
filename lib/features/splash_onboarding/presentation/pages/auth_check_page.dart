import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di.dart';
import '../../../../config/router/route_path.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../auth/presentation/blocs/auth/auth_event.dart';
import '../../../auth/presentation/blocs/auth/auth_state.dart';
import '../../../../core/services/session/session_manager.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class AuthCheckPage extends StatelessWidget {
  const AuthCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        repository: sl<AuthRepository>(),
        session: sl<SessionManager>(),
      )..add( AuthCheckStatus()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(
                context,
                RoutePaths.mainLayout,
              );
            });
          } else if (state is AuthUnauthenticated || state is AuthFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(
                context,
                RoutePaths.login,
              );
            });
          }
        },
        child: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}