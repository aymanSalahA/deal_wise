import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;
  final Color accentColor;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
    Color? backgroundColor,
    Color? accentColor,
  })  : backgroundColor = backgroundColor ?? const Color(0xFFEAF4FF),
        accentColor = accentColor ?? const Color(0xFF0EA5E9);

  static List<OnboardingModel> getOnboardingPages() {
    return [
      OnboardingModel(
        title: 'Discover Deals',
        description: 'Curated offers, daily drops, and exclusive savings just for you.',
        imagePath: 'assets/images/first.jpg',
        backgroundColor: const Color(0xFFEAF4FF),
        accentColor: const Color(0xFF0EA5E9),
      ),
      OnboardingModel(
        title: 'Shop Smarter',
        description: 'Compare, wishlist, and checkout seamlessly across categories.',
        imagePath: 'assets/images/second.jpg',
        backgroundColor: const Color(0xFFFFF3E6),
        accentColor: const Color(0xFFF59E0B),
      ),
      OnboardingModel(
        title: 'Earn Rewards',
        description: 'Collect points as you buy and redeem them for more.',
        imagePath: 'assets/images/third.jpg',
        backgroundColor: const Color(0xFFF3E8FF),
        accentColor: const Color(0xFF8B5CF6),
      ),
    ];
  }
}
