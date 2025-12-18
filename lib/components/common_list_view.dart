import 'package:flutter/material.dart';

class CommonListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final String emptyMessage;
  final IconData emptyIcon;
  final EdgeInsetsGeometry padding;

  const CommonListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.emptyMessage = 'No items found',
    this.emptyIcon = Icons.info_outline,
    this.padding = const EdgeInsets.only(bottom: 20),
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              emptyIcon,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: padding,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index], index);
      },
    );
  }
}
