import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  const SocialButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: theme.iconTheme.color ?? theme.colorScheme.onSurface,
        ),
        onPressed: () {},
      ),
    );
  }
}
