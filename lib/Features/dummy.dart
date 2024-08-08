// #005151

//Finding The best quote

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class QuoteMeScreen extends StatelessWidget {
//   const QuoteMeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
            
//             FirebaseAuth.instance.signOut().then((value) {
//               Get.offNamed('/signin');
//             });
//           },
//           child: const Text('Logout'),
//         ),
//       ),
//     );
//   }
// }