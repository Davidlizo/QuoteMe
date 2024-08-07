import 'package:flutter/material.dart';

import 'Features/quote_me/pages/quote_me_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(QuoteMe());
}

class QuoteMe extends StatelessWidget {
  const QuoteMe({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      
      home: QuoteMeScreen(),
    );
  }
}
