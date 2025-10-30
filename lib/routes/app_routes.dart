import 'package:deal_wise/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/reset_password.dart';
import '../features/auth/presentation/screens/dummy_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
  static const String dummy = '/dummy';

  static Map<String, WidgetBuilder> routes = {
    // splash: (context) => SplashScreen(),
    // onBoarding: (context) => const OnboardingScreen(),
    // login: (context) => const LoginScreen(),
    // forgotPassword: (context) => ForgotPasswordScreen(),
    // resetPassword: (context) => ResetPasswordScreen(),
    // dummy: (context) => const DummyScreen(),
    home: (context) => const HomeScreen(),
  };
}
