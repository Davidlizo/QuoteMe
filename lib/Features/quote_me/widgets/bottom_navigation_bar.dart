import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';
import '../pages/favourite_screen.dart';
import '../pages/profile_screen.dart';
import '../pages/quote_me_screen.dart';


class NavScreens extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  NavScreens({super.key});

  final List<Widget> _screens = [
    const QuoteMeScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          index: controller.currentIndex.value,
          onTap: controller.changeIndex,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white70,
          color: const Color(0xff005151),
          items: const [
            Icon(Icons.home_outlined, color: Colors.white,),
            Icon(Icons.favorite_border_outlined, color: Colors.white,),
            Icon(Icons.person_outline_outlined, color: Colors.white,),
          ],
        );
      }),
    );
  }
}
