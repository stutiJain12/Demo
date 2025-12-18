import 'package:flutter/material.dart';

class CommonScrollView extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics? physics;
  final Axis scrollDirection;

  const CommonScrollView({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.physics = const BouncingScrollPhysics(),
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      physics: physics,
      scrollDirection: scrollDirection,
      child: child,
    );
  }
}
