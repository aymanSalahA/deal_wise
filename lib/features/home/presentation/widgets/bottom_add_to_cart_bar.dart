// ملف: bottom_add_to_cart_bar.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../cart/data/services/cart_service.dart';
import '../../data/models/product_model.dart';

class BottomAddToCartBar extends StatefulWidget {
  final ProductModel product;
  
  const BottomAddToCartBar({super.key, required this.product});

  @override
  State<BottomAddToCartBar> createState() => _BottomAddToCartBarState();
}

class _BottomAddToCartBarState extends State<BottomAddToCartBar> {
  final CartService _cartService = CartService();
  int quantity = 1;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: theme.colorScheme.primary),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  },
                ),
                Text(
                  '$quantity',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: theme.colorScheme.primary),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () async {
                  print('🔘 Add to Cart button pressed!');
                  print('📦 Product ID: ${widget.product.id}');
                  print('🔢 Quantity: $quantity');
                  setState(() => _isLoading = true);
                  try {
                    await _cartService.addToCart(widget.product.id, quantity);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('✅ $quantity item(s) added to the cart'),
                          duration: const Duration(seconds: 2),
                          backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('❌ Error: $e'),
                          duration: const Duration(seconds: 2),
                          backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.error,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      );
                    }
                  } finally {
                    if (mounted) {
                      setState(() => _isLoading = false);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        'Add to Cart',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
