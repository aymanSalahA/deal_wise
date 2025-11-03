import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingModel> _pages = OnboardingModel.getOnboardingPages();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() async {
    // Set flag that onboarding is complete
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    // Navigate to login screen
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(model: _pages[index]);
            },
          ),

          // Top-right Skip
          if (_currentPage < _pages.length - 1)
            Positioned(
              top: 16,
              right: 16,
              child: TextButton(
                onPressed: _completeOnboarding,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black.withOpacity(0.7),
                ),
                child: const Text('Skip'),
              ),
            ),

          // Bottom controls: indicators + CTA
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                      (index) {
                        final bool isActive = _currentPage == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          height: 8,
                          width: isActive ? 22 : 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                            color: isActive
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                    ),
                    child: Text(
                        _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                    ),
                  ),
                ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
