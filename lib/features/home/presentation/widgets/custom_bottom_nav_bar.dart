import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.bottomNavigationBarTheme.backgroundColor ?? theme.cardColor,
      child: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor ?? theme.colorScheme.primary,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor ?? theme.colorScheme.onSurface.withOpacity(0.7),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            selectedColor: theme.colorScheme.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text("Profile"),
            selectedColor: theme.colorScheme.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_bag_outlined),
            title: const Text("Cart"),
            selectedColor: theme.colorScheme.primary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_circle_outline),
            title: const Text("Add Product"),
            selectedColor: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
