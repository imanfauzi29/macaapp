import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Util {
  static timeAgo(String date) {
    return timeago.format(DateTime.parse(date));
  }
}
