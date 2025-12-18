import 'package:flutter/material.dart';
import 'package:demo/components/index.dart';
import 'package:demo/config/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'About & Details'),
      body: CommonListView<Map<String, dynamic>>(
        padding: const EdgeInsets.all(8.0),
        items: AppConstants.accordionItems,
        itemBuilder: (context, item, index) {
          return CustomCard(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.zero,
            child: CustomExpansionTile(
              leading:
                  const Icon(Icons.label_important, color: Colors.blueAccent),
              title: item['title'],
              children: [
                CustomText(
                  item['content'],
                  style: CustomTextStyle.body,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
