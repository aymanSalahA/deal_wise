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
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                if (email.isNotEmpty)
                  Text(
                    email,
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
