import 'package:deal_wise/features/home/data/models/product_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD

class ProductCardWidget extends StatefulWidget {
  final ProductCartAnimation viewModel;

  const ProductCardWidget({super.key, required this.viewModel});

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<double> _iconScaleAnimation;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _iconScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _iconController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    widget.viewModel.toggleFavorite();
    _iconController.forward().then((_) => _iconController.reverse());
=======
import 'package:dio/dio.dart';
import '../../data/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final Dio _dio = Dio();

  ProductCardWidget({super.key, required this.product});

  Future<void> _addToCart(BuildContext context) async {
    try {
      final response = await _dio.post(
        'https://accessories-eshop.runasp.net/api/cart',
        data: {'productId': product.id, 'quantity': 1},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Added to cart successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚠️ Failed: ${response.statusMessage}'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error adding to cart: $e'), backgroundColor: Colors.red),
      );
    }
>>>>>>> origin/cart-feature
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final product = widget.viewModel.product;
    final double finalPrice =
        product.price * (1 - product.discountPercentage / 100);
=======
    final double finalPrice = product.price * (1 - product.discountPercentage / 100);
>>>>>>> origin/cart-feature

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product-detail', arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(82, 255, 220, 220),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 119, 119, 119),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Image.network(
                        product.coverPictureUrl,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
<<<<<<< HEAD
                      child: ScaleTransition(
                        scale: _iconScaleAnimation,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: AnimatedBuilder(
                            animation: widget.viewModel,
                            builder: (context, _) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  widget.viewModel.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                onPressed: _toggleFavorite,
                              );
                            },
                          ),
                        ),
=======
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.favorite_border, color: Colors.red, size: 16),
>>>>>>> origin/cart-feature
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: GoogleFonts.cairo(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${finalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.caladea(
                    color: const Color(0xFF003366),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < product.rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${product.reviewsCount})',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
<<<<<<< HEAD
=======
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: 42,
                height: 42,
                child: FloatingActionButton(
                  heroTag: product.id,
                  onPressed: () => _addToCart(context),
                  backgroundColor: const Color(0xFF5BC2FA),
                  child: const Icon(Icons.add, color: Colors.white, size: 24),
                ),
              ),
            ),
>>>>>>> origin/cart-feature
          ],
        ),
      ),
    );
  }
}
