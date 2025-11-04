import 'package:deal_wise/features/splash/data/service_splach_screen.dart';
import 'package:deal_wise/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final ServiceSplachScreen _viewModel = ServiceSplachScreen();
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _viewModel.startProgress(
      onUpdate: (p) {
        if (mounted) setState(() => _progress = p);
      },
    );
    _navigateNext();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  Future<void> _navigateNext() async {
    final next = await _viewModel.getNextRoute();
    if (!mounted) return;

    switch (next) {
      case 'onboarding':
        Navigator.pushReplacementNamed(context, AppRoutes.onBoarding);
        break;
      case 'home':
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      default:
        Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset(
                      'assets/log/logo.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your Marketplace',
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff0A2843),
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    minHeight: 15,
                    value: _progress,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 58, 161, 245),
                    ),
                    backgroundColor: const Color.fromARGB(110, 33, 149, 243),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Loading ${(_progress * 100).toInt()}%',
                  style: GoogleFonts.montaguSlab(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
