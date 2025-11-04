import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  final String description;
  const ProductDescription({super.key, required this.description});
  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    const int maxLines = 4;
    final bool showReadMore =
        widget.description.split('\n').length > maxLines ||
        widget.description.length > 200;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),

          Text(
            widget.description,
            style: const TextStyle(color: Colors.grey, height: 1.5),
            maxLines: _isExpanded ? 20 : maxLines,
            overflow: TextOverflow.ellipsis,
          ),

          if (showReadMore)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? 'Read Less' : 'Read More',
                style: TextStyle(
                  color: Colors.blue.shade300,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
