import 'package:intl/intl.dart';

extension PriceFormat on num {
  String get format {
    return NumberFormat.decimalPattern().format(this);
  }
}
