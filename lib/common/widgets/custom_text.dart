import 'package:flutter/material.dart';

///-----Customize this class according to your needs
///Like font family text size font weight et.....
///
///
class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  const CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.textColor,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: fontSize, color: textColor, fontWeight: fontWeight),
    );
  }
}
