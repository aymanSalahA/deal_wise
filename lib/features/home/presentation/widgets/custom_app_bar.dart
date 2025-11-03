import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CircleAvatar(backgroundImage: AssetImage('assets/log/appstore.png')),
      ),
      title: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          String greeting = 'Hello';
          if (snapshot.hasData) {
            final prefs = snapshot.data!;
            final firstName = prefs.getString('userFirstName') ?? '';
            final lastName = prefs.getString('userLastName') ?? '';
            final displayName = (firstName.isNotEmpty || lastName.isNotEmpty)
                ? [firstName, lastName].where((s) => s.isNotEmpty).join(' ')
                : '';
            greeting = displayName.isNotEmpty ? 'Hello, $displayName' : 'Hello';
          }
          return Text(greeting, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(Icons.light_mode_outlined, color: Colors.black),
        ),
      ],
    );
  }
}
