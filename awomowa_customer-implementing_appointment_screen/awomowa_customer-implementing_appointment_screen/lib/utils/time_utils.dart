import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  const TimeUtils._();
  static String convertLLLDDYYYYDate(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('dd LLLL yyyy');
    final String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  static String convertddLLLYYYYDate(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('dd LLL yyyy');
    final String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  static bool checkDate(DateTime selectedDate, {DateTime actualDate}) {
    if (selectedDate.day == actualDate.day &&
        selectedDate.month == actualDate.month &&
        selectedDate.year == actualDate.year) {
      return true;
    }
    return false;
  }

//Date Format ForAPi
  static String converttoAPIdateFormat(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
    final String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  static String convertAmPM(String value) {
    final TimeOfDay converted = convertTimeofDay(value);
    if (converted.hour > 12) {
      final TimeOfDay returning =
          TimeOfDay(hour: converted.hour - 12, minute: converted.minute);
      final String data = convertHIS(returning);
      return "${data.replaceRange(5, data.length, "")} PM";
    }
    if (value == "00:${converted.minute}:00") {
      return "12:${converted.minute} AM";
    }
    if (value == "00:00:00") {
      return "12:00 AM";
    }
    if (converted.hour < 12) {
      final String data = convertHIS(converted);
      return "${data.replaceRange(5, data.length, "")} AM";
    } else {
      return "${value.replaceRange(5, value.length, "")} PM";
    }
  }

  static String convertHIS(TimeOfDay time, {bool showSecond = true}) {
    final String formattedTime =
        '${(time.hour <= 9) ? "0${time.hour}" : time.hour}:${(time.minute <= 9) ? "0${time.minute}" : time.minute}${showSecond ? ':00' : ''}';
    return formattedTime;
  }

  static TimeOfDay convertTimeofDay(String s) {
    final TimeOfDay convertedTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    return convertedTime;
  }
}
