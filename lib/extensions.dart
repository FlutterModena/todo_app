import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// The main [BuildContext] extension.
extension ContextExtension on BuildContext {
  /// A shortcut to get the [TextTheme] of the current theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// A shortcut to get the [ColorScheme] of the current theme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

/// The main [DateTime] extension.
extension DateTimeExtension on DateTime {
  /// A shortcut to format the date using the [DateFormat] class.
  String format(String format) => DateFormat(format).format(this);

  /// A shortcut to check if the date is today.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// A shortcut to check if the date is tomorrow.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }
}
