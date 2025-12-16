import 'dart:async';
import 'package:demo/screens/data_fetch_screen.dart';
import 'package:demo/screens/expense.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/theme/app_theme.dart';
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

/* ================= SPLASH SCREEN ================= */

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 Logo (Using FlutterLogo as placeholder since asset is missing)
            const FlutterLogo(size: 100),
            const SizedBox(height: 24),
            Text(
              "Welcome to Demo App",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
            ),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}

/* ================= BOTTOM MENU ================= */

class BottomMenu extends StatefulWidget {
  final Function(ThemeMode) onThemeChange;
  final ValueNotifier<ThemeMode> themeNotifier;

  const BottomMenu({
    super.key,
    required this.onThemeChange,
    required this.themeNotifier,
  });

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedItem = 0;

  List<Widget> get _pages => [
        HomePage(
          onThemeChange: widget.onThemeChange,
          currentMode: widget.themeNotifier.value,
        ),
        const ExpenseHomePage(),
        const DataFetchScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Application')),

      /* ============ DRAWER ============ */
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              accountName: const Text("Stuti Jain"),
              accountEmail: const Text("stuti@example.com"),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() => _selectedItem = 0);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Expenses'),
              onTap: () {
                setState(() => _selectedItem = 1);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.cloud_download),
              title: const Text('Network Data'),
              onTap: () {
                setState(() => _selectedItem = 2);
                Navigator.pop(context);
              },
            ),

            const Divider(),

            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Theme",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            ValueListenableBuilder<ThemeMode>(
              valueListenable: widget.themeNotifier,
              builder: (_, currentMode, __) {
                return Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: const Text("Light Theme"),
                      value: ThemeMode.light,
                      groupValue: currentMode,
                      onChanged: (value) {
                        widget.onThemeChange(value!);
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text("Dark Theme"),
                      value: ThemeMode.dark,
                      groupValue: currentMode,
                      onChanged: (value) {
                        widget.onThemeChange(value!);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),

      /* ============ BODY ============ */
      body: _pages[_selectedItem],

      /* ============ BOTTOM BAR ============ */
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedItem,
          onTap: (value) {
            setState(() {
              _selectedItem = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).cardColor,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: "Expenses",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_download_outlined),
              activeIcon: Icon(Icons.cloud_download),
              label: "Network",
            ),
          ],
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: .fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: .center,
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
