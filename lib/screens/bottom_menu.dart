import 'package:flutter/material.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/screens/expense.dart';
import 'package:demo/screens/data_fetch_screen.dart';
import 'package:demo/components/index.dart';

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
      appBar: const CustomAppBar(title: 'My Application'),

      /* ============ DRAWER ============ */
      drawer: CustomDrawer(
        accountName: "Stuti Jain",
        accountEmail: "stuti@email.com",
        items: [
          DrawerItem(
            title: 'Home',
            icon: Icons.home,
            onTap: () {
              setState(() => _selectedItem = 0);
              Navigator.pop(context);
            },
          ),
          DrawerItem(
            title: 'Expenses',
            icon: Icons.attach_money,
            onTap: () {
              setState(() => _selectedItem = 1);
              Navigator.pop(context);
            },
          ),
          DrawerItem(
            title: 'Network Data',
            icon: Icons.cloud_download,
            onTap: () {
              setState(() => _selectedItem = 2);
              Navigator.pop(context);
            },
          ),
        ],
        footer: ValueListenableBuilder<ThemeMode>(
          valueListenable: widget.themeNotifier,
          builder: (_, currentMode, __) {
            return CustomColumn(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: CustomText(
                    "Theme",
                    style: CustomTextStyle.bodyBold,
                  ),
                ),
                RadioListTile<ThemeMode>(
                  title: const CustomText("Light Theme"),
                  value: ThemeMode.light,
                  groupValue: currentMode,
                  onChanged: (value) {
                    widget.onThemeChange(value!);
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const CustomText("Dark Theme"),
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
      ),

      /* ============ BODY ============ */
      body: _pages[_selectedItem],

      /* ============ BOTTOM BAR ============ */
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedItem,
        onTap: (value) => setState(() => _selectedItem = value),
        items: [
          BottomNavItem(label: "Home", icon: Icons.home),
          BottomNavItem(label: "Expenses", icon: Icons.attach_money),
          BottomNavItem(label: "Network", icon: Icons.cloud_download),
        ],
      ),
    );
  }
}
