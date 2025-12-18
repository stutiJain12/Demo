import 'package:flutter/material.dart';
import 'package:demo/components/custom_text.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final Function(T?) onChanged;
  final String? label;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.itemBuilder,
    required this.onChanged,
    this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: itemBuilder(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
