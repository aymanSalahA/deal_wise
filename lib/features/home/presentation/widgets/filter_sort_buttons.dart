 import 'package:flutter/material.dart';

 
class FilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const FilterButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xffC8E6F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.filter_list, size: 20, color: Color(0xFF003366)),
              SizedBox(width: 8),
              Text(
                'Filter',
                style: TextStyle(
                  color: Color(0xFF003366),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 
class SortButton extends StatelessWidget {
  final VoidCallback onTap;

  const SortButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xffC8E6F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sort, size: 20, color: Color(0xFF003366)),
              SizedBox(width: 8),
              Text(
                'Sort',
                style: TextStyle(
                  color: Color(0xFF003366),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}