import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/log/appstore.png'),
        ),
      ),
      title: Text(
        'Hello, Nour',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
