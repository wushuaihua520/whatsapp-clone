import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.bgColor = primaryColor,
    this.textSize = 14,
    this.fontWeight = FontWeight.w500,
    this.height = 40,
    required this.press,
    this.radius = 40,
  });
  final String text;
  final Color textColor;
  final Color bgColor;
  final double textSize;
  final FontWeight fontWeight;
  final double height;
  final VoidCallback press;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: bgColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
