import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension DateTimeExtension on DateTime {
  String format(String format) => DateFormat(format).format(this);
}