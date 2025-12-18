import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final GlobalKey<FormState>? formKey;

  const CustomForm({
    super.key,
    required this.children,
    this.spacing = 20,
    this.padding,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          children: children.expand((widget) {
            return [
              widget,
              SizedBox(height: spacing),
            ];
          }).toList()
            ..removeLast(), // Remove the last spacing
        ),
      ),
    );
  }
}
