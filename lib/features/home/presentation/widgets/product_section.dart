 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'product_card_widget_new.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: theme.colorScheme.primary,
                size: 40,
              ),
            ),
          );
        }

        if (state is ProductFailurer) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: TextStyle(color: theme.colorScheme.error),
            ),
          );
        }

        if (state is ProductSuccess) {
          if (state.products.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Center(
                child: Text(
                  'No products found',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Featured Products',
                  style: GoogleFonts.nunito(
                    shadows: [
                      Shadow(
                        color: theme.shadowColor.withOpacity(0.4),
                        offset: Offset(1, 2),
                        blurRadius: 10,
                      ),
                    ],
                    color: theme.colorScheme.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    // Slightly increased to prevent bottom overflow
                    mainAxisExtent: 276,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductCardWidget(
                      product: product,
                      initialFavorite: false,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
