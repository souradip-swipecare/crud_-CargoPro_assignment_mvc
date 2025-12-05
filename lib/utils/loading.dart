import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlay {
  static void show() {
    print("open");
    if (Get.isDialogOpen != true) {
      print("ffhf");
      Get.dialog(
        Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CircularProgressIndicator(),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  static void hide() {
    print("ffhfghfgh");
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
