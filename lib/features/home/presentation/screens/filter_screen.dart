 

import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final String? initialCategory;
  final double? initialMinPrice;
 

  const FilterScreen({
    super.key,
    this.initialCategory,
    this.initialMinPrice,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? _selectedCategory;
  TextEditingController _minPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _minPriceController.text = widget.initialMinPrice?.toString() ?? '';
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Products'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter Options', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            
          
            TextField(
              controller: _minPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Minimum Price',
              ),
            ),
            
          
            
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  
                  final results = {
                    'category': _selectedCategory,
                    'minPrice': double.tryParse(_minPriceController.text),
                  };
              
                  Navigator.pop(context, results);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5BC2FA),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Apply Filters', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}