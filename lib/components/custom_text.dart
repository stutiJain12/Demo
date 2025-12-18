import 'package:flutter/material.dart';

enum CustomTextStyle {
  heading,
  subHeading,
  bodyBold,
  body,
  subtitle,
  label,
}

class CustomText extends StatelessWidget {
  final String text;
  final CustomTextStyle style;
  final Color? color;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomText(
    this.text, {
    super.key,
    this.style = CustomTextStyle.body,
    this.color,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;

    switch (style) {
      case CustomTextStyle.heading:
        textStyle = const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        );
        break;
      case CustomTextStyle.subHeading:
        textStyle = const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        );
        break;
      case CustomTextStyle.bodyBold:
        textStyle = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        );
        break;
      case CustomTextStyle.body:
        textStyle = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        );
        break;
      case CustomTextStyle.subtitle:
        textStyle = const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        );
        break;
      case CustomTextStyle.label:
        textStyle = const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
        break;
    }

    return Text(
      text,
      textAlign: textAlign,
      style: textStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
