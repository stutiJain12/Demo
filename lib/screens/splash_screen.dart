import 'dart:async';
import 'package:flutter/material.dart';
import 'package:demo/components/index.dart';
import 'package:demo/screens/bottom_menu.dart';

class SplashScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChange;
  final ValueNotifier<ThemeMode> themeNotifier;

  const SplashScreen({
    super.key,
    required this.onThemeChange,
    required this.themeNotifier,
  });

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BottomMenu(
            onThemeChange: widget.onThemeChange,
            themeNotifier: widget.themeNotifier,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: CustomColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            // 🔹 Logo
            const FlutterLogo(size: 100),
            CustomText(
              "Welcome to Demo App",
              style: CustomTextStyle.heading,
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
