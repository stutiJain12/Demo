import 'package:demo/components/custom_container.dart';
import 'package:demo/components/custom_column.dart';
import 'package:demo/components/custom_text.dart';
import 'package:flutter/material.dart';

class CommonBottomSheet {
  static void show({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = true,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return CustomContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          borderRadius: 25,
          color: Theme.of(context).cardColor,
          child: CustomColumn(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomContainer(
                width: 40,
                height: 5,
                borderRadius: 2.5,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomText(
                    title,
                    style: CustomTextStyle.subHeading,
                  ),
                ),
              Flexible(child: child),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
