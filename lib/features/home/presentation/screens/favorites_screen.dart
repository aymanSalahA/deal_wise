import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/product_model.dart';
import '../../data/models/product_cart_animation.dart';
import '../widgets/product_card_widget.dart';

class FavoritesScreen extends StatelessWidget {
  final List<ProductModel> favorites;

  const FavoritesScreen({super.key, required this.favorites});
  static List<ProductModel> getFavoritesFromArgs(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return (args is List<ProductModel>) ? args : <ProductModel>[];
  }

  @override
  Widget build(BuildContext context) {
    final favoriteList = favorites.isNotEmpty
        ? favorites
        : getFavoritesFromArgs(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF72C9F8),
        centerTitle: true,
      ),
      body: favoriteList.isEmpty
          ? Center(
              child: Text(
                'No favorites yet!',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final product = favoriteList[index];
                final viewModel = ProductCartAnimation(
                  product: product,
                  isFavorite: true, 
                );
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ProductCardWidget(viewModel: viewModel),
                );
              },
            ),
    );
  }
}
