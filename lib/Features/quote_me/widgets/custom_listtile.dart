import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final Widget leading;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(title, style: GoogleFonts.aBeeZee(fontSize: 20)),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
