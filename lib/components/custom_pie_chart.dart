import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:demo/components/custom_text.dart';

class PieChartDataModel {
  final double value;
  final String title;
  final Color color;

  PieChartDataModel({
    required this.value,
    required this.title,
    required this.color,
  });
}

class CustomPieChart extends StatelessWidget {
  final List<PieChartDataModel> data;
  final double height;
  final double centerSpaceRadius;
  final double sectionsSpace;

  const CustomPieChart({
    super.key,
    required this.data,
    this.height = 200,
    this.centerSpaceRadius = 40,
    this.sectionsSpace = 2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PieChart(
        PieChartData(
          sectionsSpace: sectionsSpace,
          centerSpaceRadius: centerSpaceRadius,
          sections: data.map((item) {
            return PieChartSectionData(
              value: item.value,
              title: item.title,
              color: item.color,
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
