import 'package:flutter/material.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const ProfileHeader(),
            const SizedBox(height: 20),

            const ProfileOptionTile(icon: Icons.favorite_border, title: 'Favourites'),
            const ProfileOptionTile(icon: Icons.download_outlined, title: 'Downloads'),

            const Divider(thickness: 1, color: Colors.black26),
            const SizedBox(height: 20),

            const ProfileOptionTile(icon: Icons.language, title: 'Languages'),
            const ProfileOptionTile(icon: Icons.location_on_outlined, title: 'Location'),
            const ProfileOptionTile(icon: Icons.subscriptions_outlined, title: 'Subscription'),
            const ProfileOptionTile(icon: Icons.display_settings_outlined, title: 'Display'),

            const Divider(thickness: 1, color: Colors.black26),
            const SizedBox(height: 20),

            const ProfileOptionTile(icon: Icons.delete_outline, title: 'Clear Cache'),
            const ProfileOptionTile(icon: Icons.history, title: 'Clear History'),
            const ProfileOptionTile(icon: Icons.logout, title: 'Log Out'),

            const SizedBox(height: 25),
            const Text(
              'App Version 2.3',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
