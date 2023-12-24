import 'package:flutter/material.dart';
import 'package:letshelp/theme/colors.dart';

class TadFormFeild extends StatelessWidget {
  const TadFormFeild({
    Key? key,
    this.shadowColor,
    this.elevetion,
    this.hintText,
    this.label,
    this.labaleColor,
    this.labelWeight,
    this.validation,
    this.controller,
    this.icon,
    this.isPassword,
    this.isRequierd = false,
    this.textInputType,
    this.isColumn = false,
    this.readOnly = false,
    this.stringHelperText,
  }) : super(key: key);

  final Color? shadowColor;
  final double? elevetion;
  final String? hintText;
  final String? label;
  final Color? labaleColor;
  final FontWeight? labelWeight;
  final String? Function(String? val)? validation;
  final TextEditingController? controller;
  final IconData? icon;
  final TextInputType? textInputType;
  final bool? isPassword;
  final bool isRequierd;
  final bool isColumn;
  final String? stringHelperText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isColumn
            ? Text(
                "$stringHelperText",
                style: TextStyle(color: kTeal400),
              )
            : Container(),
        TextFormField(
          readOnly: readOnly,
          obscureText: isPassword ?? false,
          controller: controller,
          validator: validation,
          keyboardType: textInputType ?? TextInputType.text,
          decoration: InputDecoration(
            helperText: isRequierd ? "مطلوب *" : null,
            helperStyle: TextStyle(color: Colors.red),
            suffixIcon: Icon(
              icon ?? null,
              color: kTeal400.withOpacity(0.6),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 19,
              horizontal: 19,
            ),
            hintText: hintText ?? "",
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                label != null ? "$label" : "",
                style: TextStyle(
                  color: labaleColor ?? kTeal400,
                  fontWeight: labelWeight ?? FontWeight.bold,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: kTeal400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: kTeal400),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: kTeal400),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: kTeal400),
            ),
          ),
        ),
      ],
    );
  }
}
