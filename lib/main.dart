import 'package:flutter/material.dart';
import 'features/auth/presentation/screens/reset_password.dart';
import 'features/auth/presentation/screens/dummy_screen.dart';
import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deal Wise',
      debugShowCheckedModeBanner: false,
      initialRoute: '/reset-password',
      routes: {
        '/': (_) => const DummyScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
        // '/screen-one': (context) => ScreenOne(),
      },
    );
  }
}
