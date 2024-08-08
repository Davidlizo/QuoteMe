import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../contoller/auth_controllers.dart';
import '../widget/button.dart';
import '../widget/custom_textfield.dart';

import '../widget/route_to_signup.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
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

    String validateUsername(String? username) {
      if (username == null || username.isEmpty) {
        return 'Please enter a username';
      }
      return '';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Sign Up With Quote Me Today',
                      style: GoogleFonts.quicksand(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('❝ Find The Right Quote ❞',
                      style: GoogleFonts.sansita(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          color: Colors.white)),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomTextfield(
                    controller: _userNameTextController,
                    isPasswordtype: false,
                    icon: Icons.person_outline,
                    text: 'Enter UserName',
                    validator: validateUsername,
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
                const SizedBox(
                  height: 15.0,
                ),

                // Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Button(
                    onTap: () {
                      String usernameError =
                          validateUsername(_userNameTextController.text);
                      String emailError =
                          validateEmail(_emailTextController.text);
                      String passwordError =
                          validatePassword(_passwordTextController.text);

                      if (emailError.isEmpty &&
                          passwordError.isEmpty &&
                          usernameError.isEmpty) {
                        authController.usernameController.text =
                            _userNameTextController.text;
                        authController.emailController.text =
                            _emailTextController.text;
                        authController.passwordController.text =
                            _passwordTextController.text;
                        authController.signUp();
                      } else {
                        String errorMessages = '';

                        // Append errors to a single string
                        if (usernameError.isNotEmpty) {
                          errorMessages += '$usernameError\n';
                        }
                        if (emailError.isNotEmpty) {
                          errorMessages += '$emailError\n';
                        }
                        if (passwordError.isNotEmpty) {
                          errorMessages += '$passwordError\n';
                        }

                        if (errorMessages.endsWith('\n')) {
                          errorMessages = errorMessages.substring(
                              0, errorMessages.length - 1);
                        }

                        // Show combined errors in Snackbar
                        Get.snackbar(
                          'Error',
                          errorMessages,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          backgroundColor:
                              const Color.fromARGB(167, 23, 76, 25),
                          duration: const Duration(seconds: 5),
                        );
                      }
                    },
                    title: 'SIGN UP',
                  ),
                ),
                const SizedBox(height: 15),
                //Route TO Signup
                RouteToSignup(
                  onpressed: () {
                    Get.offNamed('/signin');
                  },
                  text: 'Already Have An Account?',
                  subText: 'Sign In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
