import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // Save user authentication state
  Future<void> saveUserSession(bool rememberMe) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (rememberMe) {
        await prefs.setString('email', emailController.text);
        await prefs.setString('password', passwordController.text);
      } else {
        await prefs.remove('email');
        await prefs.remove('password');
      }
      await prefs.setBool('remember_me', rememberMe);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save user session. Please try again.',
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(167, 23, 76, 25),
      );
    }
  }

  // Load saved user authentication state
  Future<void> loadUserSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      bool rememberMe = prefs.getBool('remember_me') ?? false;
      if (rememberMe && email != null && password != null) {
        emailController.text = email;
        passwordController.text = password;
        signIn();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user session. Please try again.',
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(167, 23, 76, 25),
      );
    }
  }

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await userCredential.user?.updateDisplayName(usernameController.text);
      Get.offNamed('/signin');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during sign up. Please try again later.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
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
        'An unexpected error occurred during sign up. Please try again.',
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
        final prefs = await SharedPreferences.getInstance();
        bool rememberMe = prefs.getBool('remember_me') ?? false;
        await saveUserSession(rememberMe);
        Get.offNamed('/quote_me');
      } else {
        Get.snackbar(
          'Error',
          'Unable to retrieve user information. Please try again.',
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color.fromARGB(167, 23, 76, 25),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Invalid email or password. Please check and try again.';
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
      Get.snackbar(
        'Error',
        'An unexpected error occurred during sign in. Please try again.',
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(167, 23, 76, 25),
      );
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await _auth.signOut(); // Sign out from Firebase
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('email'); // Remove email from shared preferences
      await prefs.remove('password'); // Remove password from shared preferences
      await prefs.remove('remember_me'); // Remove remember_me flag

      // Navigate to the login screen
      Get.offNamed('/signin');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to log out. Please try again.',
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(167, 23, 76, 25),
      );
    }
  }
}
