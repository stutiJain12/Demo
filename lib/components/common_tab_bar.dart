import 'package:flutter/material.dart';

class CommonTabBar extends StatelessWidget {
  final List<String> tabs;
  final TabController? controller;
  final void Function(int)? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final Color? backgroundColor;

  const CommonTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: indicatorColor ?? Colors.blueAccent,
        ),
        labelColor: selectedColor ?? Colors.white,
        unselectedLabelColor: unselectedColor ?? Colors.grey.shade600,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent, // Remove default underline
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        tabs: tabs.map((tabName) => Tab(text: tabName)).toList(),
      ),
    );
  }
}

/*
USAGE EXAMPLE:

1. Wrap your Scaffold body (or column) with DefaultTabController (or use a TabController).
2. Plave CommonTabBar where you want the tabs.
3. Place Expanded(child: TabBarView(...)) below it if inside a Column.

DefaultTabController(
  length: 2,
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: CommonTabBar(
          tabs: const ['Tab 1', 'Tab 2'],
        ),
      ),
      Expanded(
        child: TabBarView(children: [
          Center(child: Text("Page 1")),
          Center(child: Text("Page 2")),
        ]),
      )
    ],
  ),
)
*/
