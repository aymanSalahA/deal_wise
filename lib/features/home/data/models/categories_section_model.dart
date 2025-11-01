import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final bool isSelected;

  CategoryModel({
    required this.name,
    required this.icon,
    this.isSelected = false,
  });

  CategoryModel copyWith({bool? isSelected}) {
    return CategoryModel(
      name: name,
      icon: icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
