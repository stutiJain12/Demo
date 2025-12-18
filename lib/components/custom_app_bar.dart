import 'package:flutter/material.dart';
import 'package:demo/components/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final double elevation;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = true,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
        title,
        style: CustomTextStyle.subHeading,
        color: foregroundColor ?? Theme.of(context).appBarTheme.foregroundColor,
      ),
      actions: actions,
      leading: leading,
      backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      foregroundColor: foregroundColor ?? Theme.of(context).appBarTheme.foregroundColor,
      centerTitle: centerTitle,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
