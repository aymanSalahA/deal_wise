import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
  });

  static List<OnboardingModel> getOnboardingPages() {
    return [
      OnboardingModel(
        title: 'Welcome to Dealwise',
        description: 'Best place to find the best deals',
        imagePath: 'assets/images/first.jpg',
        backgroundColor: Colors.blue.shade50,
      ),
      OnboardingModel(
        title: 'Find whatever you want',
        description: 'Our shop has all your needs',
        imagePath: 'assets/images/second.jpg',
        backgroundColor: Colors.orange.shade50,
      ),
      OnboardingModel(
        title: 'Shop and win',
        description: 'Every time you shop, you get points that you can redeem',
        imagePath: 'assets/images/third.jpg',
        backgroundColor: Colors.purple.shade50,
      ),
    ];
  }
}
