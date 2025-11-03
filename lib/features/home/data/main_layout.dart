import 'package:deal_wise/features/add_product/presentation/screens/add_product_screen.dart';
import 'package:deal_wise/features/cart/presentation/screens/cart_screen.dart';
import 'package:deal_wise/features/home/presentation/screens/home_screen.dart';
import 'package:deal_wise/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:deal_wise/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';

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
    const CartPage(),
    const AddProductScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Ensure currentIndex is within bounds
    final safeIndex = _currentIndex.clamp(0, _screens.length - 1);
    
    return Scaffold(
      body: _screens[safeIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index >= 0 && index < _screens.length) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
