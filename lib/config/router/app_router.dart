import 'package:decoro/config/router/route_path.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/blocs/verification/verification_event.dart';
import '../../features/auth/presentation/pages/forgot_password_select_screen.dart';
import '../../features/auth/presentation/pages/get_started_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/verification_page.dart';
import '../../features/splash_onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash_onboarding/presentation/pages/splash_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RoutePaths.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RoutePaths.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case RoutePaths.getLetStart:
        return MaterialPageRoute(builder: (_) => const GetStartedPage());
      case RoutePaths.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case RoutePaths.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordSelectScreen());
      case RoutePaths.verificationCode:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => VerificationPage(
            email: args['email'] as String,
            type: args['type'] as VerificationType,
          ),
        );
      case RoutePaths.resetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ResetPasswordScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}