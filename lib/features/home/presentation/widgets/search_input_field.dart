import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Color(0xff5E6F88), size: 26),
          hintText: 'Search of Products...',
          hintStyle: TextStyle(
            color: Color(0xff7B8A9E),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: Icon(Icons.tune, color: Color(0xff7E8B9F), size: 26),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: const Color(0xffE2E8F0),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xff27AAED)),
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
