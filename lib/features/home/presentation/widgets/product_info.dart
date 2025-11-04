// ملف: product_info.dart
import 'package:deal_wise/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final ProductModel product;
  final double discountedPrice;

  const ProductInfo({
    super.key,
    required this.product,
    required this.discountedPrice,
  });

  @override
  Widget build(BuildContext context) {
    final String productName = product.name;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sleek Furnishings',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            productName,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${discountedPrice.toStringAsFixed(2)}',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              if (product.discountPercentage > 0)
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              const Spacer(),
              Icon(Icons.star, color: theme.colorScheme.secondary, size: 18),
              const SizedBox(width: 4),
              Text(
                '${product.rating.toDouble().toStringAsFixed(1)} (${product.reviewsCount} reviews)',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
