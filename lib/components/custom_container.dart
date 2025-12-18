import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final AlignmentGeometry? alignment;
  final Gradient? gradient;

  const CustomContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius = 0,
    this.boxShadow,
    this.border,
    this.alignment,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius > 0 ? BorderRadius.circular(borderRadius) : null,
        boxShadow: boxShadow,
        border: border,
        gradient: gradient,
      ),
      child: child,
    );
  }
}
