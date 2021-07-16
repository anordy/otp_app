import 'package:flutter/material.dart';

class Utils {
  /// get screen height and width
  static Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// get  screen width
  static double displayWidth(BuildContext context) {
    return displaySize(context).width;
  }

  /// get screen height
  static double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  /// Time Manipulations
  static String getTime(int seconds) {
    final duration = Duration(seconds: seconds);
    var time = '';

    if (duration.inMinutes > 59) {
      int hours = duration.inHours;

      int minutes = (duration.inSeconds % 3600) ~/ 60;

      int seconds = (duration.inSeconds % 3600) % 60;

      time = (hours < 10 ? '0$hours' : '$hours') +
          ':' +
          (minutes < 10 ? '0$minutes' : '$minutes') +
          ':' +
          (seconds < 10 ? '0$seconds' : '$seconds');
    } else if (duration.inMinutes > 0 && duration.inMinutes < 60) {
      int minutes = duration.inMinutes;

      int seconds = duration.inSeconds % 60;

      time = (minutes < 10 ? '0$minutes' : '$minutes') +
          ':' +
          (seconds < 10 ? '0$seconds' : '$seconds');
    } else {
      time = (duration.inSeconds < 10
          ? '0${duration.inSeconds}'
          : '${duration.inSeconds}');
    }

    return time;
  }
}
