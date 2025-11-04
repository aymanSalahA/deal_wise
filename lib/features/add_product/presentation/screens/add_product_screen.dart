import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Category model to store id and name
  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategoryId;

  // Product image URL - using a valid placeholder that actually works
  String _imageUrl = 'https://picsum.photos/300/300';

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      print('Token from SharedPreferences: $token');

      final url = Uri.parse(
        'https://accessories-eshop.runasp.net/api/categories',
      );

      // Build headers - token might not be required for public categories
      final headers = <String, String>{'Content-Type': 'application/json'};
      if (token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(url, headers: headers);
      print('Categories response status: \\${response.statusCode}');
      print('Categories response body: \\${response.body}');

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          print('Response data type: ${responseData.runtimeType}');
          print(
            'Categories key exists: ${responseData.containsKey("categories")}',
          );

          if (responseData.containsKey('categories')) {
            final List<dynamic> data =
                responseData['categories'] as List<dynamic>;
            print('Categories count: ${data.length}');

            setState(() {
              _categories = data
                  .map<Map<String, dynamic>>(
                    (category) => {
                      'id': category['id'] as String,
                      'name': category['name'] as String,
                    },
                  )
                  .toList();
            });
            print('✅ Successfully loaded ${_categories.length} categories');
          } else {
            throw Exception('Response does not contain "categories" key');
          }
        } catch (parseError, stackTrace) {
          print('❌ Parse error: $parseError');
          print('Stack trace: $stackTrace');
          setState(() {
            _errorMessage = 'Error parsing categories: $parseError';
          });
        }
      } else {
        setState(() {
          _errorMessage =
              'Failed to fetch categories. (Status: \\${response.statusCode})';
        });
      }
    } catch (e, stackTrace) {
      print('❌ Error fetching categories: $e');
      print('Stack trace: $stackTrace');
      setState(() {
        _errorMessage = 'Error fetching categories: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoading = false;
  String? _errorMessage;

  // Static data
  static const String _sellerId = 'd051dbf3-f5d8-410d-0e50-08de06562562';
  static const String _nameArabic = 'منتج 1';
  static const String _descriptionArabic = 'اختبار المنتج';
  static const String _coverPictureUrl = '';
  static const int _weight = 1;
  static const int _discountPercentage = 1;
  // Remove static categoryIds, will use selected category
  static const List<String> _productPictureUrls = [''];

  Future<void> _addProduct() async {
    if (_selectedCategoryId == null) {
      setState(() {
        _errorMessage = 'Please select a category.';
      });
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = Uri.parse('https://accessories-eshop.runasp.net/api/products');
    try {
      // Get token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      print('Token for add product: $token');

      final price =
          double.tryParse(_priceController.text.replaceAll(',', '.')) ?? 1;
      final requestBody = {
        'sellerId': _sellerId,
        'name': _nameController.text,
        'description': _descriptionController.text,
        'nameArabic': _nameArabic,
        'descriptionArabic': _descriptionArabic,
        'coverPictureUrl': _imageUrl,
        'price': price,
        'stock': 1,
        'weight': _weight,
        'color': 'Red',
        'discountPercentage': _discountPercentage,
        'categoryIds': [_selectedCategoryId],
        'productPictureUrls': _productPictureUrls,
      };
      print('Sending request: ' + jsonEncode(requestBody));
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );
      print('Response status: \\${response.statusCode}');
      print('Response body: \\${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Product added successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          // Navigate to MainLayout (home) instead of just popping
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/home', (route) => false);
        }
      } else {
        setState(() {
          _errorMessage =
              'Failed to add product. (Status: \\${response.statusCode})\\nBody: \\${response.body}';
        });
      }
    } catch (e, stack) {
      print('Exception: $e');
      print('Stacktrace: $stack');
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F8),
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          'Add Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xFF101C22),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF101C22)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 8),
              Text(
                'Product Name',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter product name',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Category',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedCategoryId,
                hint: _categories.isEmpty
                    ? const Text('Loading categories...')
                    : const Text('Select a category'),
                items: _categories
                    .map(
                      (cat) => DropdownMenuItem(
                        value: cat['id'] as String,
                        child: Text(cat['name'] as String),
                      ),
                    )
                    .toList(),
                onChanged: _categories.isEmpty
                    ? null
                    : (val) => setState(() => _selectedCategoryId = val),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                ),
                validator: (value) =>
                    value == null ? 'Select a category' : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Price',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  prefixText: 'EGP ',
                  hintText: '0.00',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter product description...',
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 56),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFF6F7F8),
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF13A4EC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onPressed: _isLoading
                ? null
                : () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _addProduct();
                    }
                  },
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Create Product'),
          ),
        ),
      ),
    );
  }
}
