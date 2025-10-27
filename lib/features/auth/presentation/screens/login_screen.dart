import 'package:deal_wise/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/social_button.dart';  
import 'otp_verification_screen.dart';  
 
import 'package:deal_wise/features/auth/data/models/auth_view_model.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(AuthViewModel authVM) async {
   
    if (_formKey.currentState!.validate()) {
      
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

    
      bool success = await authVM.login(email, password);
      
      if (success) { 
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              verificationTarget: email,  
            ),
          ),
        );
      } else {
       
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authVM.errorMessage ?? 'Login failed. Check server connection.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final authVM = Provider.of<AuthViewModel>(context); 

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form( 
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 60,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
 
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'you@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  
                  validator: (value) => Validator.validateEmail(value!), 
                ),
                const SizedBox(height: 20),
                
               
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  
                  validator: (value) => Validator.validatePassword(value!),
                ),
                const SizedBox(height: 10),

            
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () { /* Navigation to Forgot Password */ },
                    child: const Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
                  ),
                ),
                const SizedBox(height: 20),

               
                authVM.isLoading
                    ? const CircularProgressIndicator() 
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _handleLogin(authVM), 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),

             
                const Text('or continue with', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialButton(icon: Icons.g_mobiledata),
                    const SizedBox(width: 20),
                    SocialButton(icon: Icons.facebook),
                    const SizedBox(width: 20),
                    SocialButton(icon: Icons.apple),
                  ],
                ),
                const SizedBox(height: 40),

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Don't have an account?", style: TextStyle(color: Colors.grey)),
                    TextButton(
                      onPressed: () { /* Navigation to Sign Up screen */ },
                      child: const Text('Sign Up', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
