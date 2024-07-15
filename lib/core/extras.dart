import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:featureminds/core/utils/error_handler.dart';
import 'package:http/http.dart' as http;

import 'logger.dart';
import 'network/service_response.dart';

String tokens = "";

class ApiHeaders {

  static Map<String, String> headersNoAuth() => {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.connectionHeader: "keep-alive",
      };

  static Map<String, String> headersSessionAuth() => {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.connectionHeader: "keep-alive",
        "x-access-token": "Bearer $tokens"
      };

  static Map<String, String> headersSessionToken(String token) => {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.connectionHeader: "keep-alive",
        "x-access-token": "Bearer $token"
      };

  static Map<String, String> headersSessionEntityAuthFormData() => {
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        HttpHeaders.connectionHeader: "keep-alive",
        "x-access-token": "Bearer $tokens",
      };

  static Map<String, String> getHeadersForRequest({String? token, bool isFormData = false}) {
    if (isFormData) {
      logPrint(headersSessionEntityAuthFormData());
      return headersSessionEntityAuthFormData();
    } else if (token != null) {
      return headersSessionToken(token);
    } else if (tokens != "") {
      logPrint(headersSessionAuth());
      return headersSessionAuth();
    } else {
      logPrint(headersNoAuth());
      return headersNoAuth();
    }
  }
}

bool noAuth(Failure error) {
  if (error.statusCode != null && (error.statusCode == 401)) {
    return true;
  }
  return false;
}

ServiceResponse<T> processServiceError<T>(error, [StackTrace? stack]) {
  logPrint("$error\n$stack");
  if (error is Failure) {
    return serveError<T>(
      failure: error,
      message: error.errors.first,
      notAuthenticated: noAuth(error),
    );
  } else if (error is Exception) {
    return serveError<T>(message: error.toString());
  } else {
    return serveError<T>(message: error.toString());
  }
}

String handleException(Exception e) {
  if (e is SocketException) {
    logSocketException(e);
    if (e.message.contains("Failed host lookup")) {
      return "Something went wrong, please try again later";
    }
    return "Request failed, please try again";
  } else if (e is TimeoutException) {
    logTimeoutException(e);
    return "Request timed out, please try again";
  } else if (e is FormatException || e is ClientException) {
    logPrint(e);
    return "Something went wrong, please try again";
  } else {
    return e.toString();
  }
}

class Failure {
  Failure({
    required this.errors,
    this.statusCode,
  });

  List<String> errors;
  int? statusCode;

  factory Failure.fromResponse(http.Response response) {
    List<String> err = [];
    var error = jsonDecode(response.body);
    if (error["errors"] != null) {
      for (var item in error["errors"].values) {
        err.add(item);
      }
    }
    if (error["message"] != null) {
      err.add(error["message"]);
    }

    return Failure(
      errors: err,
      statusCode: response.statusCode,
    );
  }

  @override
  String toString() {
    return 'Failure{errors: $errors, statusCode: $statusCode}';
  }
}
