import 'package:assignmettask/data/network/api_constants.dart';
import 'package:assignmettask/exceptions/network_exceptions.dart';
import 'package:assignmettask/utils/error_handler.dart';
import 'package:dio/dio.dart';


class ApiService {
  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,   // BASE URL SET HERE
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<dynamic> get(String path) async {
    try {
      final res = await dio.get(path);
      return res.data;
    } catch (e) {
      final error = NetworkExceptions.handle(e);
      ErrorHandler.show(error);
      throw error;
    }
  }

  Future<dynamic> post(String path, dynamic data) async {
    try {
      final res = await dio.post(path, data: data);
      return res.data;
    } catch (e) {
      final error = NetworkExceptions.handle(e);
      ErrorHandler.show(error);
      throw error;
    }
  }

  Future<dynamic> put(String path, dynamic data) async {
    try {
      final res = await dio.put(path, data: data);
      return res.data;
    } catch (e) {
      final error = NetworkExceptions.handle(e);
      ErrorHandler.show(error);
      throw error;
    }
  }

  Future<void> delete(String path) async {
    try {
      await dio.delete(path);
    } catch (e) {
      final error = NetworkExceptions.handle(e);
      ErrorHandler.show(error);
      throw error;
    }
  }
}
