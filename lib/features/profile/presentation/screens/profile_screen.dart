import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/data/api_service/logout_service.dart';
import 'package:deal_wise/routes/app_routes.dart';

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
            ProfileOptionTile(
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('accessToken') ?? '';
                try {
                  if (token.isNotEmpty) {
                    await LogoutService().logout(accessToken: token);
                  }
                } catch (_) {}
                await prefs.remove('accessToken');
                await prefs.remove('refreshToken');
                await prefs.remove('expiresAtUtc');
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),

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
