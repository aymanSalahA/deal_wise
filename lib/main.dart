import 'package:deal_wise/features/home/data/models/product_model.dart';
import 'package:deal_wise/features/home/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deal_wise/routes/app_routes.dart';
import 'package:deal_wise/features/auth/data/api_service/login_service.dart';
import 'package:deal_wise/features/auth/data/api_service/otp_service.dart';
import 'package:deal_wise/features/auth/presentation/cubit/login_cubit.dart';
import 'package:deal_wise/features/auth/presentation/cubit/otp_verification_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit(service: LoginService())),
        BlocProvider(
          create: (_) => OtpVerificationCubit(
            email: '',
            otp: '',
            verificationTarget: '',
            service: OtpService(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Deal Wise',
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.productDetail) {
            final product = settings.arguments as ProductModel;
            return MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product),
            );
          }
          return null; // أي route تاني يستخدم الـ routes العادية
        },
      ),
    );
  }
}
