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
      dynamic items;
      if (data is List) {
        items = data;
      } else if (data is Map<String, dynamic>) {
        items = data['items'] ?? data['products'] ?? [];
      } else {
        items = [];
      }

      return (items as List)
          .whereType<dynamic>()
          .map<ProductModel>((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final url = 'https://accessories-eshop.runasp.net/api/products/$id';
      await dio.delete(url);
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
