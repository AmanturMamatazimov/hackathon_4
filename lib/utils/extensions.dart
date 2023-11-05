import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  // String get dottedHMFormat => DateFormat('hh:mm').format(this);
  // String? get nullableDottedDMYFormat => DateFormat('dd.MM.yy').format(this);
  // String get dottedDMYFormat => DateFormat('dd.MM.yy').format(this);
  String? get dottedDMYYYYFormat => DateFormat('dd.MM.yyyy').format(this);
  // String get dottedDMYHMFormat => DateFormat('dd.MM.yy - hh:mm').format(this);
  // String get dottedDMYHM2Format =>
  //     DateFormat('dd.MM.yy   (hh:mm)').format(this);
}
