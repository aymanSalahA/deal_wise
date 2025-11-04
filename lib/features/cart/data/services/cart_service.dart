import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://accessories-eshop.runasp.net/api/cart';

  // Get authorization headers with token
  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // 🧺 Get cart items
  Future<List<Map<String, dynamic>>> fetchCart() async {
    try {
      final headers = await _getHeaders();
      print('📦 Fetching cart from: $baseUrl');
      print('🔑 Token: ${headers['Authorization']}');
      
      final response = await _dio.get(
        baseUrl,
        options: Options(headers: headers),
      );
      
      print('✅ Cart response status: ${response.statusCode}');
      print('📄 Cart response data: ${response.data}');
      
      if (response.statusCode == 200) {
        // Handle both array and object responses
        if (response.data is List) {
          final List data = response.data as List;
          return data.map((e) => Map<String, dynamic>.from(e)).toList();
        } else if (response.data is Map) {
          // If response is wrapped in an object
          final Map<String, dynamic> responseMap = response.data;
          // Check for 'cartItems' key (actual API response)
          if (responseMap.containsKey('cartItems')) {
            final List data = responseMap['cartItems'] as List;
            print('✅ Found ${data.length} items in cart');
            return data.map((e) => Map<String, dynamic>.from(e)).toList();
          }
          // Fallback to 'items' key
          if (responseMap.containsKey('items')) {
            final List data = responseMap['items'] as List;
            return data.map((e) => Map<String, dynamic>.from(e)).toList();
          }
        }
      }
      print('⚠️ No cart items found, returning empty list');
      return [];
    } catch (e) {
      print('❌ Error fetching cart: $e');
      rethrow;
    }
  }

  // ➕ Add item to cart
  Future<void> addToCart(String productId, int quantity) async {
    try {
      final headers = await _getHeaders();
      final url = '$baseUrl/items';
      final requestData = {'productId': productId, 'quantity': quantity};
      
      print('🛒 Adding to cart: $url');
      print('📦 Request data: $requestData');
      print('🔑 Token: ${headers['Authorization']}');
      
      final response = await _dio.post(
        url,
        data: requestData,
        options: Options(headers: headers),
      );
      
      print('✅ Add to cart response status: ${response.statusCode}');
      print('📄 Add to cart response: ${response.data}');
    } catch (e) {
      print('❌ Error adding to cart: $e');
      if (e is DioException) {
        print('❌ DioException details:');
        print('   Status code: ${e.response?.statusCode}');
        print('   Response data: ${e.response?.data}');
        print('   Message: ${e.message}');
      }
      rethrow;
    }
  }

  // ❌ Remove item from cart
  Future<void> removeFromCart(String id) async {
    final headers = await _getHeaders();
    await _dio.delete(
      '$baseUrl/items/$id',
      options: Options(headers: headers),
    );
  }

  // 🔁 Update quantity
  Future<void> updateQuantity(String id, int quantity) async {
    final headers = await _getHeaders();
    await _dio.put(
      '$baseUrl/items/$id',
      data: {'quantity': quantity},
      options: Options(headers: headers),
    );
  }
}
