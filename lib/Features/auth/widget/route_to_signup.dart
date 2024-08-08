import 'package:flutter/material.dart';

class RouteToSignup extends StatelessWidget {
  final VoidCallback onpressed;
  final String text;
  final String subText;

  const RouteToSignup({
    required this.text,
    required this.subText,
    required this.onpressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )),
        TextButton(
          onPressed: onpressed,
          child: Text(
            subText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
