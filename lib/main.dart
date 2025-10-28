import 'package:deal_wise/features/auth/data/models/auth_view_model.dart';
// import 'package:deal_wise/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: MyApp(onboardingComplete: onboardingComplete),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboardingComplete;

  const MyApp({super.key, required this.onboardingComplete});
  @override
  Widget build(BuildContext context) {
    String initialRoute;
    if (!onboardingComplete) {
      initialRoute = AppRoutes.onBoarding;
    } else {
      initialRoute = AppRoutes.dummy;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deal Wise',
      initialRoute: initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
