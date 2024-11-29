import 'package:day6/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradient extends StatelessWidget {
  const AuthGradient({super.key, required this.name, required this.onPressed});
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.transparentColor,
            shadowColor: Pallete.transparentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          onPressed: onPressed,
          child: Text(name)),
    );
  }
}
