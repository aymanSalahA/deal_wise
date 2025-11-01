import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio dio = Dio();

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get(
        'https://accessories-eshop.runasp.net/api/products',
      );

      final data = response.data;
      final items = data is List ? data : data['products'] ?? [];

      return items.map<ProductModel>((item) => ProductModel.fromJson(item)).toList();
      
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
