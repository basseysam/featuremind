import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Duration requestDuration = const Duration(seconds: 120);

String? phoneNumberValidator(String? value) {
  String? result;
  if (value == null || value.isEmpty) {
    return "Enter a valid phone number";
  }
  String _val = value.replaceAll("-", "");
  if (_val.length < 10) {
    result = 'Enter a valid phone number';
  } else {
    result = null;
  }
  return result;
}

bool validatePassword(String? value) {
  RegExp regex = RegExp(r'^.{8,}$');
  if (value == null || value.isEmpty) {
    return false;
  } else {
    //RegExp regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(value);
  }

}

String? validateConfirmPassword(String? value, String? password) {

  if ((value == null || value.isEmpty) || (value != password)) {
    return "Enter a valid password";
  } else {
    return null;
  }
}

bool isEmail(String? email) {
  if (email == null || email.isEmpty) {
    return false;
  } else {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regExp.hasMatch(email);
  }
}

bool isName(String? name) {
  if (name == null || name.isEmpty) {
    return false;
  } else {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9._ ]{1,14}[a-zA-Z0-9._ ]$');

    return regExp.hasMatch(name);
  }
}

String? validateField(String? text, {required String result}) {
  if (text == null || text.isEmpty) {
    return result;
  } else {
    return null;
  }
}

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