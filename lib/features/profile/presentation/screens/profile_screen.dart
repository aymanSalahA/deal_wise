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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'My Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
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
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.themeSettings),
            ),
            ProfileOptionTile(
              icon: Icons.password,
              title: 'Change Password',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.changePassword),
            ),

            Divider(thickness: 1, color: Theme.of(context).dividerColor),
            const SizedBox(height: 20),

            ProfileOptionTile(
              icon: Icons.policy,
              title: 'Privacy & Policy',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.privacyPolicy),
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
                // Clear all authentication and user data
                await prefs.remove('accessToken');
                await prefs.remove('refreshToken');
                await prefs.remove('expiresAtUtc');
                await prefs.remove('userEmail');
                await prefs.remove('userFirstName');
                await prefs.remove('userLastName');
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),

            const SizedBox(height: 25),
            Text(
              'App Version 2.3',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
