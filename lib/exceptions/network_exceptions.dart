import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'app_exception.dart';

class NetworkExceptions {
  static AppException handle(dynamic error) {
    if (kDebugMode) {
      print(error);
    }
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return AppException("Connection Timeout");
        case DioExceptionType.receiveTimeout:
          return AppException("Server is not responding");
        case DioExceptionType.sendTimeout:
          return AppException("Request timed out");
        case DioExceptionType.badResponse:
          return AppException("${error.response?.data.toString()}");
        case DioExceptionType.connectionError:
          return AppException("No Internet Connection");
        default:
          return AppException("Unexpected Network Error");
      }
    }

    if (error is SocketException) {
      return AppException("No Internet Connection");
    }

    return AppException("Something went wrong");
  }
}
