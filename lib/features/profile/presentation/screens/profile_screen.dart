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

            ProfileOptionTile(
              icon: Icons.dark_mode_outlined,
              title: 'Theme',
              onTap: () => Navigator.pushNamed(context, AppRoutes.themeSettings),
            ),
            ProfileOptionTile(
              icon: Icons.password,
              title: 'Change Password',
              onTap: () => Navigator.pushNamed(context, AppRoutes.changePassword),
            ),

            const Divider(thickness: 1, color: Colors.black26),
            const SizedBox(height: 20),

            ProfileOptionTile(
              icon: Icons.policy,
              title: 'Privacy & Policy',
              onTap: () => Navigator.pushNamed(context, AppRoutes.privacyPolicy),
            ),
            ProfileOptionTile(
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () => Navigator.pushNamed(context, AppRoutes.aboutUs),
            ),
            ProfileOptionTile(
              icon: Icons.contact_support,
              title: 'Contact Us',
              onTap: () => Navigator.pushNamed(context, AppRoutes.contactUs),
            ),
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
