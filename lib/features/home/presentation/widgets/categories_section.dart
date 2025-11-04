import 'package:deal_wise/features/home/data/models/categories_section_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  int selectedIndex = 0;

  final List<CategoryModel> categories = [
    CategoryModel(name: 'All', icon: Icons.grid_view_rounded),
    CategoryModel(name: 'Electronics', icon: Icons.phone_android),
    CategoryModel(name: 'Apparel', icon: Icons.checkroom),
    CategoryModel(name: 'Accessories', icon: Icons.diamond_outlined),
    CategoryModel(name: 'Headphones', icon: Icons.headphones),
    CategoryModel(name: 'Shoes', icon: Icons.run_circle_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: GoogleFonts.nunito(
              shadows: [
                Shadow(
                  color: theme.shadowColor.withOpacity(0.25),
                  offset: const Offset(1, 2),
                  blurRadius: 5,
                ),
              ],
              color: theme.colorScheme.primary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                final category = categories[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    showCheckmark: false,
                    label: Text(
                      category.name,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : (theme.textTheme.bodyMedium?.color ?? Colors.black),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    avatar: Icon(
                      category.icon,
                      size: 20,
                      color: isSelected
                          ? Colors.white
                          : (theme.textTheme.bodyMedium?.color ?? Colors.black),
                    ),
                    selected: isSelected,
                    selectedColor: theme.chipTheme.selectedColor ??
                        theme.colorScheme.primary.withOpacity(0.15),
                    backgroundColor: theme.chipTheme.backgroundColor ??
                        theme.cardColor,
                    side: BorderSide.none,
                    onSelected: (selected) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
