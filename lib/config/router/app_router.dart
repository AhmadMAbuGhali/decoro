import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/di.dart';
import 'route_path.dart';

// Auth
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/get_started_page.dart';
import '../../features/auth/presentation/pages/forgot_password_select_screen.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/verification_page.dart';
import '../../features/auth/presentation/blocs/verification/verification_event.dart';

// Onboarding / Splash
import '../../features/splash_onboarding/presentation/pages/splash_page.dart';
import '../../features/splash_onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash_onboarding/presentation/pages/auth_check_page.dart';
import '../../features/splash_onboarding/presentation/blocs/onboarding_bloc.dart';
import '../../features/splash_onboarding/data/repositories/onboarding_repository.dart';

// Main Layout + Home
import '../../features/main_layout/presentation/pages/main_layout.dart';
import '../../features/home/presentation/pages/home_page.dart';

// Notifications
import '../../features/notifications/presentation/pages/notification_page.dart';

// Product
import '../../features/product/presentation/pages/product_detail_page.dart';
import '../../features/product/domain/entities/product.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

    // ───────────────────── Splash
      case RoutePaths.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

    // ───────────────────── Auth
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case RoutePaths.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      case RoutePaths.getLetStart:
        return MaterialPageRoute(builder: (_) => const GetStartedPage());

      case RoutePaths.authCheck:
        return MaterialPageRoute(builder: (_) => const AuthCheckPage());

    // ───────────────────── Onboarding
      case RoutePaths.onboarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OnboardingBloc(sl<OnboardingRepository>()),
            child: const OnboardingPage(),
          ),
        );

    // ───────────────────── Password Reset
      case RoutePaths.forgotPassword:
        return MaterialPageRoute(
            builder: (_) => const ForgotPasswordSelectScreen());

      case RoutePaths.verificationCode:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerificationPage(
            email: args['email'],
            type: args['type'] as VerificationType,
          ),
        );

      case RoutePaths.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

    // ───────────────────── Main Layout & Home
      case RoutePaths.mainLayout:
        return MaterialPageRoute(builder: (_) => const MainLayout());

      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

    // ───────────────────── Notifications
      case RoutePaths.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationPage());

    // ───────────────────── Product Details
      case RoutePaths.productDetails:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductDetailPage(productId: productId),
        );

    // ───────────────────── Default
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}