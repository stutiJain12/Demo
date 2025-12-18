import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;
  final double? iconSize;
  final EdgeInsetsGeometry padding;
  final String? tooltip;
  final BoxShape shape;
  final Border? border;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 40,
    this.iconSize,
    this.padding = const EdgeInsets.all(8),
    this.tooltip,
    this.shape = BoxShape.circle,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: shape,
        border: border,
      ),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(icon, color: color, size: iconSize),
          onPressed: onPressed,
          tooltip: tooltip,
        ),
      ),
    );
  }
}
