import 'package:flutter/material.dart';

class Productimage extends StatelessWidget {
  final String imageUrl;

  const Productimage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 400,
      color: theme.cardColor,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,

        width: double.infinity,
        height: 400,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            Icons.broken_image,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            size: 50,
          ),
        ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              color: theme.colorScheme.primary,
            ),
          );
        },
      ),
    );
  }
}
