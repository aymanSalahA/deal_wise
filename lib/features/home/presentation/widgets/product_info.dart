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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sleek Furnishings',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            productName,
            style: const TextStyle(
              color: Colors.black,
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
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              if (product.discountPercentage > 0)
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                '${product.rating.toDouble().toStringAsFixed(1)} (${product.reviewsCount} reviews)',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
