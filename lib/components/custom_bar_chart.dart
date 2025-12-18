import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartDataModel {
  final double x;
  final double y;
  final Color color;

  BarChartDataModel({
    required this.x,
    required this.y,
    this.color = Colors.blueAccent,
  });
}

class CustomBarChart extends StatelessWidget {
  final List<BarChartDataModel> data;
  final List<String> bottomLabels;
  final double height;
  final double barWidth;

  const CustomBarChart({
    super.key,
    required this.data,
    required this.bottomLabels,
    this.height = 220,
    this.barWidth = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: data.map((item) {
            return BarChartGroupData(
              x: item.x.toInt(),
              barRods: [
                BarChartRodData(
                  toY: item.y,
                  color: item.color,
                  width: barWidth,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < bottomLabels.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        bottomLabels[value.toInt()],
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
