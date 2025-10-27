import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/visibility_password_cubit.dart';
import '../cubit/reset_password_cubit.dart';
import '../../data/api_service/reset_password_service.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewPasswordVisibilityCubit()),
        BlocProvider(create: (context) => ConfirmPasswordVisibilityCubit()),
        BlocProvider(
          create: (context) => ResetPasswordCubit(ResetPasswordService()),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6F7F8),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
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
                // New Password Field
                BlocBuilder<NewPasswordVisibilityCubit, bool>(
                  builder: (context, obscureNewPassword) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'New Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _newPasswordController,
                          obscureText: obscureNewPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter new password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureNewPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () => context
                                  .read<NewPasswordVisibilityCubit>()
                                  .toggleVisibility(),
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
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Must be at least 8 characters.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Confirm Password Field
                BlocBuilder<ConfirmPasswordVisibilityCubit, bool>(
                  builder: (context, obscureConfirmPassword) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Confirm New Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: obscureConfirmPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Confirm new password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () => context
                                  .read<ConfirmPasswordVisibilityCubit>()
                                  .toggleVisibility(),
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
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
                // Reset Password Button
                ElevatedButton(
                  onPressed: () {
                    print('\x1B[1;42m Reset Password Pressed \x1B[0m');
                    //
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF13A4EC),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
