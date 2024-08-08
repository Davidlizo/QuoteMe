import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RememberMeButton extends StatefulWidget {
  final bool rememberMe;
  final ValueChanged<bool> onChanged;

  const RememberMeButton({
    super.key,
    required this.rememberMe,
    required this.onChanged,
  });

  @override
  State<RememberMeButton> createState() => _RememberMeButtonState();
}

class _RememberMeButtonState extends State<RememberMeButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                activeColor: const Color(0xff005151),
                value: widget.rememberMe,
                onChanged: (bool? value) {
                  widget.onChanged(value ?? false);
                },
              ),
              const Text(
                'Remember Me',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () => Get.toNamed('/forgotpassword'),
            child: const Text(
              'ForgotPassword?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
