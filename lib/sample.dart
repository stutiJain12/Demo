import 'package:demo/api_screen.dart';
import 'package:flutter/material.dart';
import 'chart_screen.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: accordionItems.length,
      itemBuilder: (context, index) {
        final item = accordionItems[index];

        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 400),
          tween: Tween(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child:Card(
  margin: const EdgeInsets.symmetric(vertical: 4.0),
  elevation: 2,
  child: ListTile(
    leading: const Icon(Icons.label_important),
    title: Text(
      item['title'],
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(item['content'], maxLines: 1, overflow: TextOverflow.ellipsis),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ChartScreen(),
        ),
      );
    },
  ),
),
        );
      },
    );
  }
}

class ServicePage extends StatelessWidget{
   const ServicePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApiScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}