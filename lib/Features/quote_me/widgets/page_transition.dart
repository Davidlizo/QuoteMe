import 'package:flutter/material.dart';

class SlideUpPageRoute extends PageRouteBuilder {
  final Widget page;

  SlideUpPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween = Tween<Offset>(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 1200),
        );
}
