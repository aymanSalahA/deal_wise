import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'product_card_widget.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: const Color.fromARGB(255, 4, 112, 219),
                size: 40,
              ),
            ),
          );
        }
    
        if (state is ProductFailurer) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
    
        if (state is ProductSuccess) {
          if (state.products.isEmpty) {
            return const Center(
              child: Text(
                'No products found',
                style: TextStyle(color: Colors.black),
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
                      const Shadow(
                        color: Colors.grey,
                        offset: Offset(1, 2),
                        blurRadius: 10,
                      ),
                    ],
                    color: Color(0xFF003366),
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
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.7,
                      ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductCardWidget(product: product);
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
