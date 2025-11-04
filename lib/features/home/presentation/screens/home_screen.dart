import 'package:deal_wise/features/home/data/models/product_model.dart';
import 'package:deal_wise/features/home/data/services/offer_service.dart';
import 'package:deal_wise/features/home/data/services/product_service.dart';
import 'package:deal_wise/features/home/presentation/cubit/offer_cubit.dart';
import 'package:deal_wise/features/home/presentation/cubit/product_cubit.dart';
import 'package:deal_wise/features/home/presentation/widgets/categories_section.dart';
import 'package:deal_wise/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:deal_wise/features/home/presentation/widgets/offers_section.dart';
import 'package:deal_wise/features/home/presentation/widgets/product_section.dart';
import 'package:deal_wise/features/home/presentation/widgets/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> favoriteProductsList = [];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OfferCubit(OfferService())..getOffers(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(ProductService())..fetchProducts(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar:  CustomAppBar(favorites: favoriteProductsList),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchInputField(),
              OffersSection(),
              SizedBox(height: 15),
              CategoriesSection(),
              SizedBox(height: 10),
              ProductSection(),
            ],
          ),
        ),
      ),
    );
  }
}
