import 'package:deal_wise/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:deal_wise/features/auth/presentation/cubit/forgot_password_state.dart';
import 'package:deal_wise/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api_service/forgot_password_service.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => ForgotPasswordCubit(ForgotPasswordService()),
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
            "Forgot Password",
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
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                CircleAvatar(
                  radius: size.width * 0.12,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                  child: Icon(
                    Icons.lock_reset_rounded,
                    color: theme.colorScheme.primary,
                    size: size.width * 0.12,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  "Reset your password",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: size.height * 0.015),
                Text(
                  "No worries! Enter the email address associated with your account, and we'll send you a link to reset your password.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: size.height * 0.045),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: theme.iconTheme.color ?? theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    hintText: "Enter your email address",
                    hintStyle: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 14,
                    ),
                    labelText: "Email Address",
                    labelStyle: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.inputDecorationTheme.enabledBorder?.borderSide.color ?? Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.06),
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerificationScreen(
                            email: state.email,
                            otp: "", // user will enter OTP on next screen
                            verificationTarget: 'reset',
                          ),
                        ),
                      );
                    } else if (state is ForgotPasswordFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Failed to send reset link"),
                          backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.error,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: size.height * 0.07,
                      child: ElevatedButton(
                        onPressed: state is ForgotPasswordLoading
                            ? null
                            : () {
                                final email = emailController.text.trim();
                                if (email.isNotEmpty) {
                                  context
                                      .read<ForgotPasswordCubit>()
                                      .sendResetLink(email);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text("Please enter email"),
                                      backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.error,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state is ForgotPasswordLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.onPrimary,
                                ),
                              )
                            : Text(
                                "Send Reset Link",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimary,
                                ),
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
    );
  }
}
