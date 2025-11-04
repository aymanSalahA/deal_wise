import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/visibility_password_cubit.dart';
import '../cubit/reset_password_cubit.dart';
import '../../data/api_service/reset_password_service.dart';
import 'package:deal_wise/routes/app_routes.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String otp;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  ResetPasswordScreen({super.key, this.email = '', this.otp = ''});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewPasswordVisibilityCubit()),
        BlocProvider(create: (context) => ConfirmPasswordVisibilityCubit()),
        BlocProvider(
          create: (context) => ResetPasswordCubit(ResetPasswordService()),
        ),
      ],
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Password reset successfully!'),
                backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.primary,
              ),
            );
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
        },
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.appBarTheme.iconTheme?.color ?? theme.iconTheme.color,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Reset Password',
              style: theme.appBarTheme.titleTextStyle ??
                  theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.appBarTheme.foregroundColor ?? theme.colorScheme.onSurface,
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
                  // const SizedBox(height: 20),
                  // const Text(
                  //   'Create new password',
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  // const Text(
                  //   'Your new password must be different from previous passwords.',
                  //   style: TextStyle(fontSize: 16, color: Colors.grey),
                  // ),
                  const SizedBox(height: 30),
                  // New Password Field
                  BlocBuilder<NewPasswordVisibilityCubit, bool>(
                    builder: (context, obscureNewPassword) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Password',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _newPasswordController,
                            obscureText: obscureNewPassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
                              hintText: 'Enter new password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureNewPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: theme.iconTheme.color ?? theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                                onPressed: () => context
                                    .read<NewPasswordVisibilityCubit>()
                                    .toggleVisibility(),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: theme.inputDecorationTheme.border?.borderSide ?? BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Must be at least 8 characters.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<ConfirmPasswordVisibilityCubit, bool>(
                    builder: (context, obscureConfirmPassword) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Confirm New Password',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: obscureConfirmPassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
                              hintText: 'Confirm new password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: theme.iconTheme.color ?? theme.colorScheme.onSurface.withOpacity(0.6),
                                ),
                                onPressed: () => context
                                    .read<ConfirmPasswordVisibilityCubit>()
                                    .toggleVisibility(),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: theme.inputDecorationTheme.border?.borderSide ?? BorderSide.none,
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
                  const SizedBox(height: 20),
                  // Error Message Display
                  BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      if (state is ResetPasswordError) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.colorScheme.error.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: theme.colorScheme.error,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  state.message,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.error,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is ResetPasswordSuccess) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Password reset successfully!',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 10),
                  // Reset Password Button
                  BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is ResetPasswordLoading
                            ? null
                            : () {
                                // Validate password match
                                if (_newPasswordController.text.isEmpty ||
                                    _confirmPasswordController.text.isEmpty) {
                                  return;
                                }

                                if (_newPasswordController.text !=
                                    _confirmPasswordController.text) {
                                  // Show mismatch error using a temporary variable
                                  final cubit = context
                                      .read<ResetPasswordCubit>();
                                  cubit.showValidationError(
                                    'Passwords do not match!',
                                  );
                                  return;
                                }

                                context
                                    .read<ResetPasswordCubit>()
                                    .resetPassword(
                                      email: email,
                                      otp: otp,
                                      newPassword: _newPasswordController.text,
                                    );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is ResetPasswordLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.onPrimary,
                                ),
                              )
                            : Text(
                                'Reset Password',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
