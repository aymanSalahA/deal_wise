import 'package:deal_wise/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:deal_wise/features/home/presentation/widgets/search_input_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(children: [SearchInputField()]),
    );
  }
}
