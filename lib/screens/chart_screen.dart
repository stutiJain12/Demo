import 'package:flutter/material.dart';
import 'package:demo/components/index.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Analytics'),
      body: CommonScrollView(
        padding: const EdgeInsets.all(16),
        child: CustomColumn(
          spacing: 24,
          children: [
            // 🔹 Dynamic Pie Chart Card
            CustomCard(
              child: CustomColumn(
                spacing: 20,
                children: [
                  const CustomText(
                    'Category Distribution',
                    style: CustomTextStyle.heading,
                    color: Colors.blueAccent,
                  ),
                  CustomPieChart(
                    data: [
                      PieChartDataModel(value: 40, title: '40%', color: Colors.blue),
                      PieChartDataModel(value: 30, title: '30%', color: Colors.orange),
                      PieChartDataModel(value: 20, title: '20%', color: Colors.green),
                      PieChartDataModel(value: 10, title: '10%', color: Colors.red),
                    ],
                  ),
                ],
              ),
            ),

            // 🔹 Dynamic Bar Chart Card
            CustomCard(
              child: CustomColumn(
                spacing: 20,
                children: [
                  const CustomText(
                    'Weekly Trends',
                    style: CustomTextStyle.heading,
                    color: Colors.blueAccent,
                  ),
                  CustomBarChart(
                    data: [
                      BarChartDataModel(x: 0, y: 5),
                      BarChartDataModel(x: 1, y: 8),
                      BarChartDataModel(x: 2, y: 6),
                      BarChartDataModel(x: 3, y: 9),
                      BarChartDataModel(x: 4, y: 4),
                    ],
                    bottomLabels: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
