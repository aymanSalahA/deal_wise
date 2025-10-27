import 'package:deal_wise/features/auth/data/models/auth_view_model.dart';
import 'package:deal_wise/features/auth/presentation/screens/forgot_password_screen.dart';
// import 'package:deal_wise/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './features/auth/presentation/screens/reset_password.dart';
import './features/auth/presentation/screens/dummy_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deal Wise',
      initialRoute: '/dummy',
      routes: {
        '/dummy': (context) => const DummyScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
      },
    );
  }
}
