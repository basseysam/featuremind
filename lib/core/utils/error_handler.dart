import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioErrorHandler {
  handleStringError(String errorMessage) {
    //showErrorToast(errorMessage);
    print('errorMessage:: $errorMessage');
  }

  handleError(DioError dioError) {
    // DialogService dialogService = DialogService();

    print('dioError.response!.data:: ${dioError.response!.data}');

    String errorMessage =
        errorMessageParser(dioError.response?.data, showSingleError: true) ??
            'An error occured';

    print('errorMessage:: $errorMessage');

    // dialogService.showSnackBar(errorMessage, appToastType: AppToastType.error);
  }

  String getErrorMessage(DioError? dioError) {
    print(dioError?.response?.data);
    return errorMessageParser(dioError?.response?.data, showSingleError: true) ??
        'An error occured';
  }

  String? errorMessageParser(Map errorJson,
      {showSingleError = false, showErrorKey = false}) {
    String? message;

    bool shouldShowMessageError = errorJson['message'] == null;

    if (errorJson['message'] is String && shouldShowMessageError)
      return errorJson['message'];

    if (errorJson['message'] is String) return errorJson['message'];

    //errorJson = errorJson['message'] != null ? errorJson['message'] : errorJson;

    List<String>? errorKeys = errorJson.keys.cast<String>().toList();

    formartErrorKey(String value) {
      String v = value.replaceAll('_', ' ');
      String res = v[0].toUpperCase() + v.substring(1);
      return res;
    }

    if (errorKeys.length > 0) {
      if (showSingleError) {
        message = errorJson[errorKeys[0]][0];
      } else {
        String _message = '';
        for (var errorKey in errorKeys) {
          String separator = _message.isEmpty ? '' : '\n';
          var err = errorJson[errorKey];
          _message += showErrorKey
              ? "$separator${formartErrorKey(errorKey)}: ${err is String ? err : err[0]}"
              : "$separator${err is String ? err : err}";
        }
        message = _message;
      }
    }

    return message;
  }
}

class ClientException implements Exception {
  final String message;
  final Uri uri;

  ClientException(this.message, this.uri);

  @override
  String toString() => message;
}
