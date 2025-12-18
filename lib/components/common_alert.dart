import 'package:demo/components/custom_text.dart';
import 'package:demo/components/custom_row.dart';
import 'package:flutter/material.dart';

class CommonAlert {
  static Future<void> show({
    required BuildContext context,
    required String title,
    String? content,
    Widget? child,
    String confirmText = 'OK',
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: CustomText(title,
              style: CustomTextStyle.subHeading, textAlign: TextAlign.center),
          content: child ??
              (content != null
                  ? CustomText(content, style: CustomTextStyle.body)
                  : null),
          actions: <Widget>[
            CustomRow(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 10,
              children: [
                if (cancelText != null)
                  TextButton(
                    child: CustomText(cancelText, color: Colors.grey),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onCancel != null) onCancel();
                    },
                  ),
                TextButton(
                  child: CustomText(confirmText,
                      style: CustomTextStyle.bodyBold,
                      color: Colors.blueAccent),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) onConfirm();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
