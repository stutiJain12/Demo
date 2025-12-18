import 'dart:async';
import 'package:demo/screens/splash_screen.dart';
import 'package:demo/theme/app_theme.dart';
import 'package:demo/components/index.dart';
import 'package:flutter/material.dart';

import 'package:demo/hive/hive_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.light);

  void changeTheme(ThemeMode mode) {
    _themeNotifier.value = mode;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "My App",

          // 🌞 Light Theme
          theme: AppTheme.lightTheme,

          // 🌙 Dark Theme
          darkTheme: AppTheme.darkTheme,

          themeMode: mode,

          home: SplashScreen(
            onThemeChange: changeTheme,
            themeNotifier: _themeNotifier,
          ),
        );
      },
    );
  }
}