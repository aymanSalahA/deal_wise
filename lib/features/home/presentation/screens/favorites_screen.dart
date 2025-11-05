import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../widgets/product_card_widget.dart';
import '../../data/services/favorites_service.dart';
import '../../data/services/product_service.dart';
import '../../presentation/cubit/product_cubit.dart';
import '../widgets/delete_button_with_confirmation.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  final ProductService _productService = ProductService();
  List<ProductModel> _favorites = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _loading = true;
    });
    try {
      final ids = await _favoritesService.getAll();
      if (ids.isEmpty) {
        setState(() {
          _favorites = [];
          _loading = false;
        });
        return;
      }

      List<ProductModel> products = [];
      try {
        final cubit = context.read<ProductCubit>();
        products = cubit.allProducts;
      } catch (_) {}

      if (products.isEmpty) {
        products = await _productService.getProducts();
      }

      final idSet = ids.toSet();
      final favs = products.where((p) => idSet.contains(p.id)).toList();
      setState(() {
        _favorites = favs;
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _favorites = [];
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _favorites.isEmpty
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
                : RefreshIndicator(
                    onRefresh: _loadFavorites,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _favorites.length,
                      itemBuilder: (context, index) {
                        final product = _favorites[index];
                        return Stack(
                          children: [
                            ProductCardWidget(
                              product: product,
                              initialFavorite: true,
                            ),
                            Positioned(
                              top: 4,
                              left: 4,
                              child: DeleteButtonWithConfirmation(
                                productId: product.id,
                                size: 22,
                                onDeleted: () async {
                                  await _favoritesService.remove(product.id);
                                  if (!mounted) return;
                                  setState(() {
                                    _favorites.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
