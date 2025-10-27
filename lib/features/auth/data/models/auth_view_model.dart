import 'package:flutter/material.dart';
import 'package:deal_wise/core/network/api_service.dart';
import '../repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  late final AuthRepository _repository;

  bool isLoading = false;
  String? errorMessage;

  AuthViewModel() {
    _repository = AuthRepository(ApiService());
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.login(email, password);

      isLoading = false;
      notifyListeners();

      if (response['success'] == true || response['status'] == 'success') {
        return true;
      } else {
        errorMessage = response['message'] ?? 'Login failed';
        return false;
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> resendOtp(String email) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.resendOtp(email);

      isLoading = false;
      notifyListeners();

      if (response['success'] == true || response['status'] == 'success') {
        return true;
      } else {
        errorMessage = response['message'] ?? 'Failed to resend OTP';
        return false;
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> validateOtp(String email, String otp) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.validateOtp(email, otp);

      isLoading = false;
      notifyListeners();

      if (response['success'] == true || response['status'] == 'success') {
        return true;
      } else {
        errorMessage = response['message'] ?? 'Invalid OTP';
        return false;
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
