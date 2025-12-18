import 'package:flutter/material.dart';
import 'package:demo/components/index.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class CustomDrawer extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final List<DrawerItem> items;
  final Widget? footer;

  const CustomDrawer({
    super.key,
    required this.accountName,
    required this.accountEmail,
    required this.items,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            accountName: CustomText(accountName, style: CustomTextStyle.bodyBold, color: Colors.white),
            accountEmail: CustomText(accountEmail, style: CustomTextStyle.body, color: Colors.white70),
          ),
          ...items.map((item) => ListTile(
                leading: Icon(item.icon, color: Theme.of(context).primaryColor),
                title: CustomText(item.title, style: CustomTextStyle.body),
                onTap: item.onTap,
              )),
          if (footer != null) ...[
            const Divider(),
            footer!,
          ],
        ],
      ),
    );
  }
}
