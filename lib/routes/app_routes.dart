import 'package:deal_wise/features/auth/presentation/screens/register_screen.dart';
import 'package:deal_wise/features/home/data/main_layout.dart';
import 'package:deal_wise/features/home/data/models/product_model.dart';
import 'package:deal_wise/features/home/presentation/screens/favorites_screen.dart';
import 'package:deal_wise/features/home/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/reset_password.dart';
import '../features/auth/presentation/screens/dummy_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../features/profile/presentation/screens/about_us_screen.dart';
import '../features/profile/presentation/screens/contact_us_screen.dart';
import '../features/profile/presentation/screens/change_password_screen.dart';
import '../features/profile/presentation/screens/theme_settings_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';
  static const String dummy = '/dummy';
  static const String mainlayout = '/mainlayout';
  static const String productDetail = '/product-detail';
  static const String privacyPolicy = '/privacy-policy';
  static const String aboutUs = '/about-us';
  static const String contactUs = '/contact-us';
  static const String changePassword = '/change-password';
  static const String themeSettings = '/theme-settings';
  static const favorites = '/favorites';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    onBoarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const RegisterAccountScreen(),
    forgotPassword: (context) => ForgotPasswordScreen(),
    resetPassword: (context) => ResetPasswordScreen(),
    dummy: (context) => const DummyScreen(),
    // home: (context) => const HomeScreen(),
    home: (context) => const MainLayout(),
    productDetail: (context) => ProductDetailsScreen(
      product: ModalRoute.of(context)?.settings.arguments as ProductModel,
    ),
    privacyPolicy: (context) => const PrivacyPolicyScreen(),
    aboutUs: (context) => const AboutUsScreen(),
    contactUs: (context) => const ContactUsScreen(),
    changePassword: (context) => const ChangePasswordScreen(),
    themeSettings: (context) => const ThemeSettingsScreen(),
    '/favorites': (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final favorites = (args is List<ProductModel>) ? args : <ProductModel>[];
      return FavoritesScreen(favorites: favorites);
    },
  };
}
