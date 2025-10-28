import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/reset_password.dart';
import '../features/auth/presentation/screens/dummy_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';

import 'package:deal_wise/features/auth/presentation/screens/forgot_password_screen.dart';

class AppRoutes {
  static const String dummy = '/dummy';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String onBoarding = '/on-boarding';

  static Map<String, WidgetBuilder> routes = {
    dummy: (context) => DummyScreen(), // Review Ok
    forgotPassword: (context) => ForgotPasswordScreen(),
    resetPassword: (context) => ResetPasswordScreen(), // ok
    onBoarding: (context) => OnboardingScreen(),
  };
}
