import 'package:deal_wise/features/auth/data/models/auth_view_model.dart';
import 'package:deal_wise/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './features/auth/presentation/screens/reset_password.dart';
import './features/auth/presentation/screens/dummy_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
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
      initialRoute: '/reset-password',
      routes: {
        '/': (_) => const DummyScreen(),
        '/reset-password': (context) => ResetPasswordScreen(),
        // '/screen-one': (context) => ScreenOne(),
      },
    );
  }
}
