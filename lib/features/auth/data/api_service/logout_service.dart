import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../core/utils/api_constants.dart';

class LogoutService {
  final Dio _dio = Dio();

  Future<void> logout({required String accessToken}) async {
    final url = '${ApiConstants.baseUrl}logout';
    log('🌍 POST $url');

    await _dio.post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }
}


