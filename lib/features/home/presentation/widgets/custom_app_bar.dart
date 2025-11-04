import 'package:deal_wise/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<ProductModel> favorites;
  const CustomAppBar({super.key, required this.favorites});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: ClipOval(
          child: Image.asset(
            'assets/log/logo.png',
            width: 50,
            height: 50,
            fit: BoxFit.fitWidth,
          ),
        ),
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
          return Text(
            greeting,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: IconButton(
            icon: const Icon(Icons.favorite_rounded, color: Color(0xFF003366)),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites', arguments: favorites);
            },
          ),
        ),
      ],
    );
  }
}
