import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../contoller/auth_controllers.dart';
import '../widget/button.dart';
import '../widget/custom_textfield.dart';
import '../widget/rememberme_button.dart';
import '../widget/route_to_signup.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool _rememberMe = false;
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    String validateEmail(String? email) {
      if (email == null || email.isEmpty) {
        return 'Please enter an email';
      }
      RegExp emailRegex = RegExp(r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.[a-zA-Z]+)*$');
      final isEmailValid = emailRegex.hasMatch(email);
      if (!isEmailValid) {
        return 'Please enter a valid email';
      }
      return '';
    }
   String validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Please enter a password';
  }
  if (password.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return '';
}

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff005151),
              Color.fromARGB(167, 23, 76, 25),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                SizedBox(
                  height: 160,
                  child: Image.asset(
                    'assets/images/splash_quote.png',
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomTextfield(
                    controller: _emailTextController,
                    isPasswordtype: false,
                    icon: Icons.email_outlined,
                    text: 'Enter Email',
                    validator: validateEmail,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomTextfield(
                    controller: _passwordTextController,
                    isPasswordtype: true,
                    icon: Icons.password_outlined,
                    text: 'Enter Password',
                    validator: validatePassword,
                  ),
                ),
                const SizedBox(height: 15.0),

                //RememberMe / Forgotpassword
                RememberMeButton(
                  rememberMe: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value;
                    });
                  },
                ),

                // Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Button(
                     onTap: () {
      String? emailError = validateEmail(_emailTextController.text);
      String? passwordError = validatePassword(_passwordTextController.text);

      if (emailError.isEmpty && passwordError.isEmpty) {
        authController.emailController.text = _emailTextController.text;
        authController.passwordController.text = _passwordTextController.text;
        authController.signIn();
      } else {
        Get.snackbar(
          'Error',
          emailError.isNotEmpty ? emailError : passwordError,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color.fromARGB(167, 23, 76, 25),
        );
      }
    },
                    title: 'SIGN IN',
                  ),
                ),
                const SizedBox(height: 15),
                //Route TO Signup
                RouteToSignup(
                  onpressed: () => Get.toNamed('/signup'),
                  text: 'Don\'t Have An Account?',
                  subText: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
