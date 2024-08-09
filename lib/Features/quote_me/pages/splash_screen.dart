import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/pages/login.dart';
import '../widgets/page_transition.dart';


class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _blinkController;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _blinkAnimation;
  late Future<bool> _checkSessionFuture;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _slideController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

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

    // Load user session before starting animations
    _checkSessionFuture = _checkSession();
  }

  Future<bool> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    bool rememberMe = prefs.getBool('remember_me') ?? false;

    if (rememberMe && email != null && password != null) {
      // If credentials are saved, navigate immediately
      Get.offNamed('/quote_me');
      return true;
    }
    return false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Only start the splash animation if there's no saved session
    _checkSessionFuture.then((hasSession) {
      if (!hasSession) {
        _startSplashAnimation();
      }
    });
  }

  Future<void> _startSplashAnimation() async {
    await _slideController.forward().orCancel;
    await _blinkController.forward().orCancel;

    // Ensure the animation frames are visible
    if (mounted) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(SlideUpPageRoute(page: const SigninScreen()));
        }
      });
    }
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
