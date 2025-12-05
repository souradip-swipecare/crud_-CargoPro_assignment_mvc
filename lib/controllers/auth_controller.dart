import 'package:assignmettask/exceptions/firebase_exceptions.dart';
import 'package:assignmettask/routes/approutes.dart';
import 'package:assignmettask/utils/error_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  RxBool loading = false.obs;
  String verificationId = "";

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
    super.onInit();
  }

  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> sendOtp(String phone) async {
    try {
      loading(true);

      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),

        verificationFailed: (e) =>
            ErrorHandler.show(FirebaseExceptions.handle(e)),

        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },

        codeSent: (verId, _) {
          verificationId = verId;
          Get.toNamed(Routes.OTP);
        },

        codeAutoRetrievalTimeout: (verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      ErrorHandler.show(FirebaseExceptions.handle(e));
    } finally {
      loading(false);
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      loading(true);

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      ErrorHandler.show(FirebaseExceptions.handle(e));
    } finally {
      loading(false);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
