import 'package:flutter/material.dart';
import 'package:letshelp/theme/colors.dart';

class TadButton extends StatelessWidget {
  const TadButton(
      {Key? key,
      required this.text,
      this.onPress,
      this.backgroundColor,
      this.elevetion,
      this.shadowColor,
      this.horizontalPadding,
      this.radius,
      this.verticalPadding})
      : super(key: key);
  final String text;
  final Function()? onPress;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevetion;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        shadowColor: shadowColor ?? kTeal400,
        elevation: elevetion ?? 10,
        backgroundColor: backgroundColor ?? kTeal400,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 10,
          horizontal: horizontalPadding ?? 30,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
      ),
    );
  }
}
