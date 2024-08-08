import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/button.dart';
import '../widget/custom_textfield.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailTextController = TextEditingController();

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
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
                      'Forgot Your Password? No Sweat!',
                      style: GoogleFonts.quicksand(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
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
                const SizedBox(height: 15.0),
                // Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Button(
                    onTap: () async {
                      final email = _emailTextController.text;
                      final emailError = validateEmail(email);

                      if (emailError.isEmpty) {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                          Get.snackbar(
                            'Success',
                            'Password reset email sent. Please check your inbox.',
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: const Color.fromARGB(167, 23, 76, 25),
                            duration: const Duration(seconds: 5),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Failed to send password reset email. Please try again later.',
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: const Color.fromARGB(167, 23, 76, 25),
                            duration: const Duration(seconds: 5),
                          );
                        }
                      } else {
                        Get.snackbar(
                          'Error',
                          emailError,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: const Color.fromARGB(167, 23, 76, 25),
                          duration: const Duration(seconds: 5),
                        );
                      }
                    },
                    title: 'Reset Password',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
