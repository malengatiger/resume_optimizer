import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/resume.dart';
import 'functions.dart';

class Utilities {
  ///calculator
  static String calcDaysHours(String dateString) {
    DateTime now = DateTime.now();
    DateTime then = DateTime.parse(dateString);
    Duration diff = now.difference(then);
    int days = diff.inDays;
    int hours = diff.inHours % 24;
    return '$days days, $hours hours';
  }


}
