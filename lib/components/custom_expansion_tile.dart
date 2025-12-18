import 'package:flutter/material.dart';
import 'package:demo/components/custom_text.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? leading;
  final Color? iconColor;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry? childrenPadding;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.leading,
    this.iconColor,
    this.initiallyExpanded = false,
    this.childrenPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: leading,
      title: CustomText(
        title,
        style: CustomTextStyle.bodyBold,
      ),
      iconColor: iconColor ?? Colors.blueAccent,
      collapsedIconColor: iconColor ?? Colors.blueAccent,
      initiallyExpanded: initiallyExpanded,
      childrenPadding: childrenPadding ?? const EdgeInsets.all(16.0),
      children: children,
    );
  }
}
