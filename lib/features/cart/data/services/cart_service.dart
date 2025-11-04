import 'package:dio/dio.dart';

class CartService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://accessories-eshop.runasp.net/api/cart';

  // 🧺 Get cart items
  Future<List<Map<String, dynamic>>> fetchCart() async {
    final response = await _dio.get(baseUrl);
    if (response.statusCode == 200) {
      final List data = response.data as List;
      return data.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  // ➕ Add item to cart
  Future<void> addToCart(int productId, int quantity) async {
    await _dio.post(baseUrl, data: {'productId': productId, 'quantity': quantity});
  }

  // ❌ Remove item from cart
  Future<void> removeFromCart(int id) async {
    await _dio.delete('$baseUrl/$id');
  }

  // 🔁 Update quantity
  Future<void> updateQuantity(int id, int quantity) async {
    await _dio.put('$baseUrl/$id', data: {'quantity': quantity});
  }
}
