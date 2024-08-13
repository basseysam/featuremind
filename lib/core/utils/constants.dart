import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


ThemeData kThemeData = ThemeData.light().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  dividerColor: AppColors.borderColor,
  primaryColor: AppColors.primaryColor,
  appBarTheme: const AppBarTheme(color: AppColors.white, scrolledUnderElevation: 0),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
);

String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  DateTime now = DateTime.now();

  String timeFormatted = DateFormat('HH:mm').format(dateTime);

  if (DateFormat('yyyyMMdd').format(dateTime) == DateFormat('yyyyMMdd').format(now)) {
    return "Today, $timeFormatted";
  } else if (DateFormat('yyyyMMdd').format(dateTime) ==
      DateFormat('yyyyMMdd').format(now.subtract(Duration(days: 1)))) {
    return "Yesterday, $timeFormatted";
  } else {
    return DateFormat('MMM d, HH:mm').format(dateTime);
  }
}