import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const CustomSafeArea({
    super.key,
    required this.child,
    this.padding,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
