import 'package:assignmettask/exceptions/app_exception.dart';
import 'package:get/get.dart';

class ErrorHandler {
  static void show(AppException e) {
    Get.snackbar(
      "Error",
      e.message,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }
}
