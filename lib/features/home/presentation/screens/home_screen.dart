import 'package:deal_wise/features/home/data/services/offer_service.dart';
import 'package:deal_wise/features/home/presentation/cubit/offer_cubit.dart';
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
    return BlocProvider(
      create: (context) => OfferCubit(OfferService())..getOffers(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
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
