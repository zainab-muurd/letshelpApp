import 'package:flutter/material.dart';

enum MySnackBarType {
  success,
  warning,
  error,
}

SnackBar MySnackBar({
  required String text,
  required MySnackBarType type,
  required BuildContext context,
  Function? onTap,
  int duration = 1,
}) {
  var theme = Theme.of(context);
  Color? backColor = theme.brightness == Brightness.dark
      ? theme.colorScheme.surface
      : type == MySnackBarType.error
          ? Colors.red[400]
          : type == MySnackBarType.success
              ? Colors.green[400]
              : Colors.orange[500];
  Color? foreColor = theme.brightness == Brightness.light
      ? theme.colorScheme.background
      : type == MySnackBarType.error
          ? Colors.red[400]
          : type == MySnackBarType.success
              ? Colors.green[400]
              : Colors.orange[500];
  return SnackBar(
    content: Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontFamily: "Almarai"),
          ),
        ),
        InkWell(
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Icon(
            type == MySnackBarType.error
                ? Icons.clear
                : type == MySnackBarType.success
                    ? Icons.check
                    : Icons.warning_rounded,
            color: foreColor,
          ),
        ),
      ],
    ),
    backgroundColor: backColor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20),
    duration: Duration(seconds: duration),
  );
}
