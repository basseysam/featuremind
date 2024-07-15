import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

formattedException(DioException e, StackTrace stackTrace){
  Logger().d(e, stackTrace: stackTrace);
  if (e.type == DioExceptionType.unknown && e.type is SocketException) {
    throw Exception('Kindly connect to the internet and try again!');
  }
  if (e.type == DioExceptionType.connectionTimeout) {
    throw Exception(
        'Timed out - This could be from us. Kindly hold on and try again later.');
  }
  if (e.type == DioExceptionType.badResponse){
    var message = e.response?.data['message'];
    throw Exception(message);
  }
  throw Exception('Unknown error occurred');
}