import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceSplachScreen {
  double progress = 0.0;
  Timer? _progressTimer;

  void startProgress({required void Function(double) onUpdate}) {
    const totalDurationMs = 5000; 
    const tickMs = 40;
    final increment = tickMs / totalDurationMs;

    _progressTimer = Timer.periodic(const Duration(milliseconds: tickMs), (timer) {
      progress += increment;
      if (progress >= 1.0) {
        progress = 1.0;
        _progressTimer?.cancel();
      }
      onUpdate(progress);
    });
  }
  Future<String> getNextRoute() async {
    await Future.delayed(const Duration(seconds: 5));

    final prefs = await SharedPreferences.getInstance();
    final bool onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

    if (!onboardingComplete) return 'onboarding';

    final accessToken = prefs.getString('accessToken');
    if (accessToken != null && accessToken.isNotEmpty) return 'home';
    return 'login';
  }

  void dispose() {
    _progressTimer?.cancel();
  }
}
