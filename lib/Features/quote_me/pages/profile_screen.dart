import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_me/Features/quote_me/pages/favourite_screen.dart';
import '../../auth/contoller/auth_controllers.dart';
import '../widgets/custom_listtile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    // Retrieve user data using getter methods
    final String username = authController.currentUserName;
    final String email = authController.currentUserEmail;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 350,
                decoration: const BoxDecoration(
                    color: Color(0xff005151),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 35.0),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Circular Avatar
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(62)),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          username.isNotEmpty
                              ? username.substring(0, 1).toUpperCase()
                              : 'U',
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Username
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Email
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(height: 45.0),

              CustomListTile(
                // on Tap
                onTap: () {
                  Get.to(() => const FavouriteScreen());
                },

                leading: const Icon(
                  Icons.favorite_outline,
                  size: 30,
                  color: Color(0xff005151),
                ),
                title: 'Wishlist',
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff005151),
                ),
              ),
              const SizedBox(height: 45.0),

              CustomListTile(
                // on Tap
                onTap: () {},

                leading: const Icon(
                  Icons.dark_mode_outlined,
                  size: 30,
                  color: Color(0xff005151),
                ),
                title: 'Dark Mode',
                trailing: Switch(
                  value: _isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                  activeColor: const Color(0xff005151),
                ),
              ),
              const SizedBox(height: 45.0),

              CustomListTile(
                // on Tap
                onTap: () {},

                leading: const Icon(
                  Icons.settings_outlined,
                  size: 30,
                  color: Color(0xff005151),
                ),
                title: 'Settings',
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff005151),
                ),
              ),

              // Logout button
              const SizedBox(height: 45.0),
              TextButton(
                onPressed: () {
                  authController.logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Logout',
                      style: GoogleFonts.lato(fontSize: 20,color: Colors.red,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
