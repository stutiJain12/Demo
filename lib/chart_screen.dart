import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Pie Chart
            const Text(
              'Category Distribution',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      title: 'A',
                      color: Colors.blue,
                    ),
                    PieChartSectionData(
                      value: 30,
                      title: 'B',
                      color: Colors.orange,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: 'C',
                      color: Colors.green,
                    ),
                    PieChartSectionData(
                      value: 10,
                      title: 'D',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 🔹 Bar Chart
            const Text(
              'Weekly Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(toY: 5, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 8, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 6, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(toY: 9, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(toY: 4, color: Colors.blue)
                    ]),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
