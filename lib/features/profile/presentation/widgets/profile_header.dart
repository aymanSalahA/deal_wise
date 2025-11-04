import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  Future<Map<String, String>> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('userFirstName') ?? '';
    final lastName = prefs.getString('userLastName') ?? '';
    final email = prefs.getString('userEmail') ?? '';
    final displayName = (firstName.isNotEmpty || lastName.isNotEmpty)
        ? [firstName, lastName].where((s) => s.isNotEmpty).join(' ')
        : email;
    return {'name': displayName, 'email': email};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _loadUser(),
      builder: (context, snapshot) {
        final name = snapshot.data?['name'] ?? 'Your Name';
        final email = snapshot.data?['email'] ?? '';
        final theme = Theme.of(context);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: theme.cardColor,
              child: Icon(
                Icons.person,
                size: 40,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                if (email.isNotEmpty)
                  Text(
                    email,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
