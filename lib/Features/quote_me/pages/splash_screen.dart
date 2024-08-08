import 'package:flutter/material.dart';
import '../../auth/pages/login.dart';
import '../widgets/page_transition.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _blinkController;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for slide-in animations
    _slideController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Start from the left
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Start from the right
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Animation controller for blinking effect
    _blinkController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _blinkAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.25,
      ),
    ]).animate(_blinkController);

    _slideController.forward().then((_) {
      // Starts blinking animation after slide-in animations
      Future.delayed(const Duration(milliseconds: 500), () {
        _blinkController.forward().whenComplete(() {
          Future.delayed(const Duration(seconds: 1), () {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(SlideUpPageRoute(page: const SigninScreen()));
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff005151),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _imageSlideAnimation,
              child: FadeTransition(
                opacity: _blinkAnimation,
                child: Image.asset('assets/images/splash_quote.png'),
              ),
            ),
            const SizedBox(height: 10),
            SlideTransition(
              position: _textSlideAnimation,
              child: const Text(
                'Finding The Best Quote',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
