import 'package:deal_wise/features/auth/data/api_service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService service;

  LoginCubit({required this.service}) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final response = await service.login(email, password);

      // Check if the response contains accessToken which indicates success
      if (response.containsKey('accessToken') && response['accessToken'] != null) {
        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        final accessToken = response['accessToken'].toString();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', response['refreshToken']?.toString() ?? '');
        await prefs.setString('expiresAtUtc', response['expiresAtUtc']?.toString() ?? '');
        
        // Save user email
        final String userEmail = (response['email'] ?? email).toString();
        await prefs.setString('userEmail', userEmail);
        
        // Only save firstName and lastName if they exist in response and are not empty
        if (response.containsKey('firstName') && response['firstName'] != null && response['firstName'].toString().isNotEmpty) {
          await prefs.setString('userFirstName', response['firstName'].toString());
          print('✅ Saved firstName: ${response['firstName']}');
        } else {
          print('⚠️ firstName not in response or empty');
        }
        if (response.containsKey('lastName') && response['lastName'] != null && response['lastName'].toString().isNotEmpty) {
          await prefs.setString('userLastName', response['lastName'].toString());
          print('✅ Saved lastName: ${response['lastName']}');
        } else {
          print('⚠️ lastName not in response or empty');
        }
        
        // Verify token was saved
        final savedToken = prefs.getString('accessToken');
        print('✅ Login successful - Token saved: ${accessToken.substring(0, 20)}...');
        print('✅ Token verification - Saved token matches: ${savedToken == accessToken}');
        print('✅ User info saved: $userEmail');
        
        emit(LoginSuccess(email));
      } else {
        emit(LoginFailure(response['message'] ?? 'Login failed'));
      }
    } catch (e) {
      emit(LoginFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
