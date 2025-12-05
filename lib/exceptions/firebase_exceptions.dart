import 'package:firebase_auth/firebase_auth.dart';
import 'app_exception.dart';

class FirebaseExceptions {
  static AppException handle(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case "invalid-verification-code":
          return AppException("Invalid OTP");
        case "session-expired":
          return AppException("OTP session expired");
        case "too-many-requests":
          return AppException("Too many attempts, try again later");
        case "invalid-phone-number":
          return AppException("Invalid phone number format");
        default:
          return AppException(error.message ?? "Authentication Error");
      }
    }

    return AppException("Unknown Firebase Error");
  }
}
