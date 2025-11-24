import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/router/route_path.dart';
import '../config/theme/app_themes.dart';
import '../config/router/app_router.dart';
import '../core/services/session/session_manager.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../features/auth/presentation/blocs/auth/auth_event.dart';
import '../shared/bloc/theme_bloc/theme_bloc.dart';
import 'di.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            repository: sl<AuthRepository>(),
            session: sl<SessionManager>(),
          )..add(AuthCheckStatus()),
        ),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Decoro',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: RoutePaths.splash,
          );
        },
      ),
    );
  }
}