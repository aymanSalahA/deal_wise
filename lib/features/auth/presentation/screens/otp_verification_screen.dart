import 'package:flutter/material.dart';
import 'dart:async'; 
import 'package:provider/provider.dart';
import '../widgets/otp_input_field.dart';  
import 'package:deal_wise/features/auth/data/models/auth_view_model.dart'; 

class OtpVerificationScreen extends StatefulWidget {
  final String verificationTarget; 

  const OtpVerificationScreen({super.key, required this.verificationTarget});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
 
  late List<TextEditingController> otpControllers; 
  late Timer _timer;
  int _start = 60; 
  bool _canResend = false; 

  @override
  void initState() {
    super.initState();
   
    otpControllers = List.generate(6, (index) => TextEditingController());
    startTimer();
  }

  void startTimer() {
   
    if (mounted) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
    _start = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_start == 0) {
        setState(() {
          _canResend = true;  
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  
  void _verifyOtp(AuthViewModel authVM) async {
 
    String enteredOtp = otpControllers.map((controller) => controller.text).join();
    
    if (enteredOtp.length == 6) {
   
      bool success = await authVM.validateOtp(widget.verificationTarget, enteredOtp);
      
      if (success) {
        _timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification successful!'), backgroundColor: Colors.green),
        );
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authVM.errorMessage ?? 'Invalid OTP'), backgroundColor: Colors.red),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit code.')),
      );
    }
  }

  
  void _resendCode(AuthViewModel authVM) async {
    if (!_canResend) return; 

    
    bool success = await authVM.resendOtp(widget.verificationTarget);
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New OTP sent successfully!'), backgroundColor: Colors.green),
      );
      startTimer();  
    } else {
    
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authVM.errorMessage ?? 'Failed to resend code'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel(); 
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);  
  
    String timerText = '00 : ${_start.toString().padLeft(2, '0')}'; 

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()), 
        backgroundColor: Colors.transparent, elevation: 0,
        title: const Text('Verify Your Account', style: TextStyle(color: Colors.black)), centerTitle: true,
      ),
      
      body: SingleChildScrollView( 
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                
                const Text('Verify Your Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 16),
              
                Text('Enter the 6-digit code we sent to ${widget.verificationTarget}.', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 50),

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) => OtpInputField(
                    controller: otpControllers[index],
                    isFirst: index == 0, 
                    isLast: index == 5,
                  )),
                ),
                const SizedBox(height: 40),
                
              
                Text(timerText, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)), 
                const SizedBox(height: 30),

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Didn't receive the code?", style: TextStyle(color: Colors.grey)),
                   
                    authVM.isLoading 
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : TextButton(
                          
                            onPressed: _canResend ? () => _resendCode(authVM) : null, 
                            child: Text('Resend', 
                              style: TextStyle(
                                color: _canResend ? Colors.blue : Colors.grey, 
                                fontWeight: FontWeight.bold
                              )
                            )
                          ),
                  ],
                ),
                const SizedBox(height: 50),

              
                authVM.isLoading
                    ? const CircularProgressIndicator()  
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _verifyOtp(authVM),  
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Verify', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
