import 'package:deal_wise/features/auth/data/api_service/otp_service.dart';
import 'package:deal_wise/features/auth/presentation/cubit/otp_verification_cubit.dart';
import 'package:deal_wise/features/auth/presentation/cubit/otp_verification_state.dart';
import 'package:deal_wise/features/auth/presentation/screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/otp_input_field.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;
  final String otp;
  final String verificationTarget;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.otp,
    required this.verificationTarget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationCubit(
        email: email,
        otp: otp,
        verificationTarget: verificationTarget,
        service: OtpService(),
      ),
      child: const _OtpVerificationView(),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  const _OtpVerificationView();

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView> {
  late List<TextEditingController> otpControllers;

  @override
  void initState() {
    super.initState();
    otpControllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OtpVerificationCubit>();
    final theme = Theme.of(context);

    String getEnteredOtp() {
      return otpControllers.map((controller) => controller.text).join();
    }

    return Scaffold(
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
          'Verify Your Account',
          style: theme.appBarTheme.titleTextStyle ??
              theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.appBarTheme.foregroundColor ?? theme.colorScheme.onSurface,
              ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<OtpVerificationCubit, OtpVerificationState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          if (state is OtpVerificationSuccess) {
            // Navigate to Reset Password when target is 'reset' or when
            // older flow passed email instead of the literal 'reset'.
            final shouldNavigateToReset =
                cubit.verificationTarget == 'reset' ||
                cubit.verificationTarget.contains('@');

            if (shouldNavigateToReset) {
              // For password reset flow, directly navigate without showing success message
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => ResetPasswordScreen(
                    email: cubit.email,
                    otp: getEnteredOtp(),
                  ),
                ),
              );
            } else {
              // For other verification flows (like registration), auto-navigate to home
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Verification successful!'),
                  backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.primary,
                ),
              );
              Navigator.pushReplacementNamed(context, '/home');
            }
          } else if (state is OtpVerificationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: theme.snackBarTheme.backgroundColor ?? theme.colorScheme.error,
              ),
            );
          }
        },
        child: BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
          builder: (context, state) {
            final String timerText =
                '00 : ${state.timer.toString().padLeft(2, '0')}';
            final bool isLoading = state is OtpVerificationLoading;

            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 40),
                      Text(
                        'Verify Your Account',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Enter the 6-digit code we sent to ${cubit.email}.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 50),

                      // OTP Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                          (index) => OtpInputField(
                            controller: otpControllers[index],
                            isFirst: index == 0,
                            isLast: index == 5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      Text(
                        timerText,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Didn't receive the code?",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          isLoading
                              ? const CircularProgressIndicator(strokeWidth: 2)
                              : TextButton(
                                  onPressed: state.canResend
                                      ? cubit.resendCode
                                      : null,
                                  child: Text(
                                    'Resend',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: state.canResend
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurface.withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(height: 50),

                      isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () =>
                                    cubit.verifyOtp(getEnteredOtp()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Verify',
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    fontSize: 18,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
