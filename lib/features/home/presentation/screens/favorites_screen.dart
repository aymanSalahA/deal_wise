import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/product_model.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.appBarTheme.iconTheme?.color ?? theme.iconTheme.color,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Favorites',
          style: theme.appBarTheme.titleTextStyle ??
              GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: theme.appBarTheme.foregroundColor ?? theme.colorScheme.onSurface,
              ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: favoriteList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No favorites yet!',
                      style: GoogleFonts.nunito(
                        fontSize: 22,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start adding some products to your favorites',
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  final product = favoriteList[index];
                  return ProductCardWidget(
                    product: product,
                    initialFavorite: true,
                  );
                },
              ),
      ),
    );
  }
}
