import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/reset_password_cubit.dart';
import '../../data/api_service/reset_password_service.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> _obscureNewPassword = ValueNotifier(true);
  final ValueNotifier<bool> _obscureConfirmPassword = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(ResetPasswordService()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6F7F8),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Reset Password',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
            builder: (context, state) {
              final cubit = context.read<ResetPasswordCubit>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Create new password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your new password must be different from previous passwords.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  // New Password
                  const Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obscureNewPassword,
                    builder: (context, obscure, _) {
                      return TextField(
                        controller: _newPasswordController,
                        obscureText: obscure,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter new password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                _obscureNewPassword.value = !obscure,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Must be at least 8 characters.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password
                  const Text(
                    'Confirm New Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obscureConfirmPassword,
                    builder: (context, obscure, _) {
                      return TextField(
                        controller: _confirmPasswordController,
                        obscureText: obscure,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Confirm new password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                _obscureConfirmPassword.value = !obscure,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // Submit Button
                  ElevatedButton(
                    onPressed: state is ResetPasswordLoading
                        ? null
                        : () {
                            log('🔹 Reset button pressed');
                            final newPassword = _newPasswordController.text.trim();
                            final confirmPassword =
                                _confirmPasswordController.text.trim();

                            if (newPassword.isEmpty ||
                                confirmPassword.isEmpty) {
                              cubit.setError('Please fill all fields.');
                              log('⚠️ Validation: empty fields');
                              return;
                            }

                            if (newPassword != confirmPassword) {
                              cubit.setError('Passwords do not match.');
                              log('⚠️ Validation: password mismatch');
                              return;
                            }

                            cubit.resetPassword(
                              email: "example@gmail.com", // change to real one
                              otp: "123456", // change to real otp
                              newPassword: newPassword,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13A4EC),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: state is ResetPasswordLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),

                  const SizedBox(height: 16),

                  // Red or green message
                  if (state is ResetPasswordFailure)
                    Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (state is ResetPasswordSuccess)
                    const Text(
                      'Password reset successfully!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
