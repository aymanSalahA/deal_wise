import 'package:deal_wise/features/cart/presentation/screens/cart_screen.dart';
import 'package:deal_wise/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:deal_wise/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:deal_wise/features/home/presentation/screens/home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
