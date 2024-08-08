import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quote_me/Features/auth/pages/forget_password.dart';


import 'Features/auth/contoller/auth_controllers.dart';
import 'Features/auth/pages/login.dart';
import 'Features/auth/pages/signup.dart';
import 'Features/quote_me/pages/quote_me_screen.dart';
import 'Features/quote_me/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Get.put(AuthController());
  runApp(const QuoteMe());
}

class QuoteMe extends StatelessWidget {
  const QuoteMe({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quote Me',
      debugShowCheckedModeBanner: false,
      home: const AnimatedSplashScreen(),
      getPages: [
        GetPage(name: '/signin', page: () => const SigninScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/quote_me', page: () => const QuoteMeScreen()),
         GetPage(name: '/forgotpassword', page: () => const ForgetPassword()),
      ],
    );
  }
}