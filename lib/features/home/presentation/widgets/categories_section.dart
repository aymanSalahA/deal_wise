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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: GoogleFonts.nunito(
              shadows: [
                const Shadow(
                  color: Color.fromARGB(255, 200, 233, 250),
                  offset: Offset(1, 2),
                  blurRadius: 5,
                ),
              ],
              color: const Color(0xFF003366),
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
                            ? const Color(0xFF3BB0EE)
                            : Color(0xff0A2843),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    avatar: Icon(
                      category.icon,
                      size: 20,
                      color: isSelected
                          ? const Color(0xFF3BB0EE)
                          : Color(0xff0A2843),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xffC8E6F5),
                    backgroundColor: const Color(0xffFEEBE7),
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
