import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../extras.dart';
import '../logger.dart';
import '../utils/constants.dart';
import 'notifiers.dart';


/*class ServiceRequest<T> {
  late final T serviceRequest;

  ServiceRequest(this.serviceRequest);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _res = {};
    _res["service_request"] = serviceRequest;
    _res["session_token"] = paySwitchUserAuth?.token;

    return _res;
  }

  @override
  String toString() {
    return 'ServiceRequest{serviceRequest: $serviceRequest}';
  }
}*/

class ServiceResponse<T> {
  late bool status;
  final int? statusCode;
  final T? data;
  final String? message;
  final Failure? failure;
  final bool notAuthenticated;

  ServiceResponse(
      {this.data,
      this.message,
      this.failure,
      required this.status,
      this.statusCode,
      this.notAuthenticated = false});

  NotifierState<T> toNotifierState() {
    return status
        ? notifyRight<T>(data: data, message: message, statusCode: statusCode)
        : notifyError<T>(
            error: message ?? "Something went wrong",
            failure: failure,
            noAuth: notAuthenticated,
          );
  }

  @override
  String toString() {
    return 'ServiceResponse{status: $status, statusCode: $statusCode, data: $data, message: $message, failure: $failure, notAuthenticated: $notAuthenticated}';
  }
}

ServiceResponse<T> serveSuccess<T>(
    {required T? data, String? message = "Success", int? statusCode}) {
  return ServiceResponse<T>(
    status: true,
    message: message,
    data: data,
    statusCode: statusCode,
  );
}

ServiceResponse<T> serveError<T>(
    {T? data, String? message, Failure? failure, bool notAuthenticated = false}) {
  return ServiceResponse<T>(
    status: false,
    message: message ?? failure!.errors.first,
    data: data,
    failure: failure,
    notAuthenticated: notAuthenticated,
  );
}

class PaginatedResponse<T> {
  PaginatedResponse({
    required this.data,
    this.prevPage,
    this.currentPage,
    this.nextPage,
    this.totalPages,
  });

  T data;
  int? prevPage;
  int? currentPage;
  int? nextPage;
  int? totalPages;

  factory PaginatedResponse.fromJson(T data, Map<String, dynamic> json) => PaginatedResponse(
        data: data,
        prevPage: json["prev_page"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson(Map<String, dynamic> data) => {
        "data": data,
        "prev_page": prevPage,
        "current_page": currentPage,
        "next_page": nextPage,
        "total_pages": totalPages,
      };

  @override
  String toString() {
    return 'PaginatedResponse{prevPage: $prevPage, currentPage: $currentPage, nextPage: $nextPage, totalPages: $totalPages, data: $data}';
  }
}

class ApiService<T> {
  Future<ServiceResponse<T>> getCall(String url,
      {required T Function(dynamic) getDataFromResponse,
      Map<String, String>? headers,
      Function(http.Response)? onReturn}) async {
    String _url = "${dotenv.env['BASE_URL']!}$url";
    logPrint(_url);
    try {
      http.Response response = await http.get(
        Uri.parse(_url),
        headers: {
          ...headers ?? ApiHeaders.getHeadersForRequest(),
        },
        // headers: headers ?? ApiHeaders.getHeadersForRequest(),
      ).timeout(requestDuration);
      if (onReturn != null) onReturn(response);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw Failure.fromResponse(response);
      } else {
        var responseBody = jsonDecode(response.body);
        return serveSuccess<T>(
            data: getDataFromResponse(responseBody),
            message:  "Successful",
            statusCode: response.statusCode);
      }
    } catch (error, stack) {
      return processServiceError<T>(error, stack);
    }
  }

}
