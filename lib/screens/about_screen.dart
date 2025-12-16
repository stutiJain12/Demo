import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const List<Map<String, dynamic>> accordionItems = [
    {
      'title': 'Item 1',
      'content':
          'This is the detailed description for Item 1. You can add more information here about this item.',
    },
    {
      'title': 'Item 2',
      'content':
          'Detailed content for Item 2 goes here. Feel free to include longer text or even multiple paragraphs.',
    },
    {
      'title': 'Item 3',
      'content':
          'Here is some information about Item 3. Expansion panels are great for FAQs or settings.',
    },
    {
      'title': 'Item 4',
      'content':
          'Item 4 description. You can customize icons, colors, and styling.',
    },
    {
      'title': 'Item 5',
      'content':
          'More details about Item 5. Supports rich text if needed.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About & Details')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: accordionItems.length,
        itemBuilder: (context, index) {
          final item = accordionItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            elevation: 2,
            child: ExpansionTile(
              leading: const Icon(Icons.label_important, color: Colors.blueAccent),
              title: Text(
                item['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(item['content']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
