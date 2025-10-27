import 'package:flutter/material.dart';
import 'features/auth/presentation/screens/reset_password.dart';

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
      // home: Scaffold(body: Center(child: Text("Start Working"))),
      initialRoute: '/',
      routes: {
        '/': (_) => ResetPasswordScreen(),
        // '/screen-one': (_) => const ScreenOne(),
        // '/screen-one': (context) => ScreenTwo(),
      },
    );
  }
}
