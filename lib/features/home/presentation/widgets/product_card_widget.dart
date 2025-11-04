import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/product_model.dart';
import '../../../cart/data/services/cart_service.dart';

class ProductCardWidget extends StatefulWidget {
  final ProductModel product;
  final bool initialFavorite;

  const ProductCardWidget({
    super.key,
    required this.product,
    this.initialFavorite = false,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  final CartService _cartService = CartService();
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  Future<void> _addToCart() async {
    print('🛍️ Product Card: Add to cart clicked!');
    print('📦 Product: ${widget.product.name}');
    print('🆔 Product ID: ${widget.product.id}');
    try {
      await _cartService.addToCart(widget.product.id, 1);
      print('✅ Product Card: Successfully added to cart');
      if (mounted) {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('✅ Added to cart successfully!'),
            backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.primary,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('❌ Product Card: Error caught - $e');
      if (mounted) {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error adding to cart: $e'),
            backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.error,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double finalPrice =
        widget.product.price * (1 - widget.product.discountPercentage / 100);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product-detail',
          arguments: widget.product,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    widget.product.coverPictureUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error, color: theme.colorScheme.error),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: theme.colorScheme.error,
                        size: 18,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cairo(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.nunito(
                fontSize: 12,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${finalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.caladea(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (widget.product.discountPercentage > 0)
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < widget.product.rating
                            ? Icons.star
                            : Icons.star_border,
                        color: theme.colorScheme.secondary,
                        size: 16,
                      );
                    }),
                    const SizedBox(width: 4),
                    Text(
                      '(${widget.product.reviewsCount})',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Prevent parent GestureDetector from triggering
                    _addToCart();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
