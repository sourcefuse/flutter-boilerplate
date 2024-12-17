import 'package:clean_arch/common/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///-----Customize this class according to your needs
///
///

enum ButtonType { outlined, filled }

Widget customButton({
  required BuildContext context,
  required VoidCallback? onPressed,
  required String buttonText,
  double? width,
  double? height,
  Color? textColor,
  Color? backgroundColor,
  Color? borderSideColor,
  double borderRadius = 30,
  ButtonType buttonType = ButtonType.filled, // Default to outlined button
}) {
  // Default colors
  borderSideColor ??= Theme.of(context).primaryColor;
  backgroundColor ??= Theme.of(context).primaryColor;
  textColor = buttonType == ButtonType.filled
      ? Colors.white
      : Theme.of(context).primaryColor;

  // Based on the button type (filled or outlined), adjust the button style
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      // If it's a filled button, use the background color, else use the border color
      side: buttonType == ButtonType.outlined
          ? BorderSide(color: borderSideColor) // Border for outlined button
          : BorderSide.none, // No border for filled button

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),

      // Customize the minimum size
      minimumSize: Size(width ?? 0.9.sw, height ?? 0.06.sh),

      // Background color for filled button
      backgroundColor: buttonType == ButtonType.filled
          ? backgroundColor // Background color for filled button
          : Colors.transparent, // No background for outlined button
    ),
    child: CustomText(
      text: buttonText,
      textColor: textColor,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
  );
}
