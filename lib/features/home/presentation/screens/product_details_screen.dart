import 'package:deal_wise/features/home/data/models/product_model.dart';
import 'package:deal_wise/features/home/presentation/widgets/bottom_add_to_cart_bar.dart';
import 'package:deal_wise/features/home/presentation/widgets/Color_options.dart';
import 'package:deal_wise/features/home/presentation/widgets/product_description.dart';
import 'package:deal_wise/features/home/presentation/widgets/product_Image.dart';
import 'package:deal_wise/features/home/presentation/widgets/product_info.dart';
import 'package:deal_wise/features/home/presentation/widgets/product_ratings.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double discountedPrice =
        product.price * (1 - product.discountPercentage / 100);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: theme.appBarTheme.iconTheme?.color ?? theme.iconTheme.color,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: theme.appBarTheme.iconTheme?.color ?? theme.iconTheme.color,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: theme.appBarTheme.iconTheme?.color ?? theme.iconTheme.color,
            ),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Productimage(imageUrl: product.coverPictureUrl),
          const SizedBox(height: 10),
          ProductInfo(product: product, discountedPrice: discountedPrice),
          ColorOptions(
            availableColors: const [
              '0xFF455A64',
              '0xFFFFA000',
              '0xFF9E9E9E',
              '0xFFFFD600',
            ],
            selectedColorCode: product.color,
          ),
          ProductDescription(description: product.description),
          ProductRatings(
            rating: product.rating.toDouble(),
            reviewsCount: product.reviewsCount,
            ratingDistribution: {
              5: 0.6,
              4: 0.25,
              3: 0.1,
              2: 0.03,
              1: 0.02,
            },
          ),
          const SizedBox(height: 80), // Add space for bottom bar
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAddToCartBar(product: product),
      ),
    );
  }
}
