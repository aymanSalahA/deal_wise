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

    String getEnteredOtp() {
      return otpControllers.map((controller) => controller.text).join();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Verify Your Account',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocListener<OtpVerificationCubit, OtpVerificationState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          if (state is OtpVerificationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Verification successful!'),
                backgroundColor: Colors.green,
              ),
            );

            if (cubit.verificationTarget == 'reset') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ResetPasswordScreen(
                    email: cubit.email,
                    otp: getEnteredOtp(),
                  ),
                ),
              );
            }
          } else if (state is OtpVerificationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
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
                      const Text(
                        'Verify Your Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Enter the 6-digit code we sent to ${cubit.email}.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
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
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Didn't receive the code?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          isLoading
                              ? const CircularProgressIndicator(strokeWidth: 2)
                              : TextButton(
                                  onPressed: state.canResend
                                      ? cubit.resendCode
                                      : null,
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: state.canResend
                                          ? Colors.blue
                                          : Colors.grey,
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
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Verify',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
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
