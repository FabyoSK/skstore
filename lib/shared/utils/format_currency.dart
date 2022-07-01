import 'dart:io';
import 'package:intl/intl.dart';

class FormatCurrency {
  static String format(double num) {
    final formatCurrency = NumberFormat.simpleCurrency(name: 'USD');

    return formatCurrency.format(num);
  }
}
