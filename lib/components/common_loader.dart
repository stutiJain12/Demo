import 'package:flutter/material.dart';

class CommonLoader extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;

  const CommonLoader({
    super.key,
    this.size = 40.0,
    this.color,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? Theme.of(context).primaryColor;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 🔹 Static method to show loader dialog
  static void show(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: CommonLoader(
            message: message,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // 🔹 Static method to hide loader dialog
  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
