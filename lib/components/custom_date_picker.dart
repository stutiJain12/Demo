import 'package:flutter/material.dart';
import 'package:demo/components/custom_text.dart';
import 'package:demo/components/custom_row.dart';
import 'package:demo/components/custom_container.dart';
import 'package:demo/components/custom_column.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final String label;
  final IconData icon;
  final Color? activeColor;
  final DateTime? lastDate;

  const CustomDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.label = 'Selected Date: ',
    this.icon = Icons.calendar_today,
    this.activeColor,
    this.lastDate,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: lastDate ?? DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: 15,
      border: Border.all(color: Colors.grey.shade300),
      child: CustomRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomRow(
            spacing: 8,
            children: [
              Icon(icon, color: activeColor ?? Theme.of(context).primaryColor),
              CustomColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(label, style: CustomTextStyle.label),
                  CustomText(
                    '${selectedDate.toLocal()}'.split(' ')[0],
                    style: CustomTextStyle.bodyBold,
                  ),
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: () => _selectDate(context),
            child: CustomText(
              'Change',
              style: CustomTextStyle.bodyBold,
              color: activeColor ?? Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
