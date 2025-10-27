import 'package:dio/dio.dart';
class ForgotPasswordService {
  final Dio _dio = Dio();

  Future<void> sendResetLink(String email) async {
    const String url =
        'https://accessories-eshop.runasp.net/scalar/#tag/auth/post/api/auth/forgot-password';

    final data = {'email': email};
    final response = await _dio.post(url, data: data);

    if (response.statusCode == 200) {
      print("✅ Reset link sent successfully");
    } else {
      throw Exception('Failed to send reset link');
    }
  }
}
