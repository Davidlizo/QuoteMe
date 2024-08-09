import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/contoller/auth_controllers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.find<AuthController>().logout();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
