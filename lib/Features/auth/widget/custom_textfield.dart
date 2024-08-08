import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPasswordtype;
  final IconData icon;
  final String text;
  final String Function(String?) validator;

  const CustomTextfield({
    super.key,
    this.controller,
    required this.isPasswordtype,
    required this.icon,
    required this.text,
    required this.validator,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _isObscured;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPasswordtype; // Set initial password visibility state
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscured,
      autocorrect: !widget.isPasswordtype,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: Colors.white70,
        ),
        suffixIcon: widget.isPasswordtype
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
        labelText: widget.text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        errorText: _errorText,
      ),
      keyboardType:
          widget.isPasswordtype ? TextInputType.visiblePassword : TextInputType.emailAddress,
      onChanged: (value) {
        setState(() {
          _errorText = widget.validator(value);
        });
      },
    );
  }
}