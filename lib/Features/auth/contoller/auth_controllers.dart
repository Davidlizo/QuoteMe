import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await userCredential.user?.updateDisplayName(usernameController.text);
      Get.offNamed('/quote_me');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during sign up';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is badly formatted.';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'Sign-up is not currently enabled.';
      }
      Get.snackbar(
        'Error',
        errorMessage,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(167, 23, 76, 25),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(167, 23, 76, 25),
      );
    }
  }

  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String? username = _auth.currentUser?.displayName;
      if (username != null) {
        Get.offNamed('/quote_me');
      } else {
        Get.snackbar(
          'Error',
          'Unable to retrieve user information',
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color.fromARGB(167, 23, 76, 25),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during sign in';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is badly formatted.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'This user account has been disabled.';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many sign-in requests. Please try again later.';
      }
      Get.snackbar(
        'Error',
        errorMessage,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(167, 23, 76, 25),
      );
    } catch (e) {
      rethrow;
    }
  }
}
