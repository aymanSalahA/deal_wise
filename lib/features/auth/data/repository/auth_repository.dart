import 'dart:convert';
import 'package:deal_wise/core/network/api_service.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('https://accessories-eshop.runasp.net/api/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Resend OTP
  Future<Map<String, dynamic>> resendOtp(String email) async {
    final url = Uri.parse('https://accessories-eshop.runasp.net/api/auth/resend-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Resend OTP failed: ${response.body}');
    }
  }

  // Validate OTP
  Future<Map<String, dynamic>> validateOtp(String email, String otp) async {
    final url = Uri.parse('https://accessories-eshop.runasp.net/api/auth/validate-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Validate OTP failed: ${response.body}');
    }
  }
}
