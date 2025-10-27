import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://accessories-eshop.runasp.net/api/';

  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse(baseUrl + endpoint);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to connect: ${response.statusCode} - ${response.body}');
    }
  }
}
