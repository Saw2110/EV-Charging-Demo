import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showSuccessSnackBar({
    required String message,
    SnackBarAction? action,
    Color backgroundColor = Colors.green,
    Duration duration = const Duration(seconds: 4),
    TextStyle? textStyle,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle ?? const TextStyle(color: Colors.white),
        ),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showErrorSnackBar({
    required String message,
    SnackBarAction? action,
    Color backgroundColor = Colors.red,
    Duration duration = const Duration(seconds: 4),
    TextStyle? textStyle,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle ?? const TextStyle(color: Colors.white),
        ),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showSnackBar({
    required String message,
    SnackBarAction? action,
    Color backgroundColor = Colors.black,
    Duration duration = const Duration(seconds: 4),
    TextStyle? textStyle,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle ?? const TextStyle(color: Colors.white),
        ),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
