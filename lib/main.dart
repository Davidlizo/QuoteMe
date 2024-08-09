import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quote_me/Features/auth/contoller/auth_controllers.dart';
import 'Features/auth/pages/login.dart';
import 'Features/auth/pages/signup.dart';
import 'Features/auth/pages/forget_password.dart';
import 'Features/quote_me/controllers/favourite_controller.dart';
import 'Features/quote_me/pages/splash_screen.dart';
import 'Features/quote_me/widgets/bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  Get.put(AuthController());      // Register AuthController with GetX
  Get.put(FavoritesController()); // Register FavoritesController with GetX
  runApp(const QuoteMe());        // Run the app
}

class QuoteMe extends StatelessWidget {
  const QuoteMe({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quote Me',
      debugShowCheckedModeBanner: false,
      home: const AnimatedSplashScreen(), // Home page of the app
      getPages: [
        GetPage(name: '/signin', page: () => const SigninScreen()), // Login page
        GetPage(name: '/signup', page: () => const SignupScreen()), // Signup page
        GetPage(name: '/quote_me', page: () =>  NavScreens()), // Main app page
        GetPage(name: '/forgotpassword', page: () => const ForgetPassword()), // Forgot password page
      ],
    );
  }
}
