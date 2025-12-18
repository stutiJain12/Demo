import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? cardColor;
  final double elevation;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.cardColor,
    this.elevation = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: leading,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
