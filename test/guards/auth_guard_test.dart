import 'package:flutter_test/flutter_test.dart';
import 'package:assignmettask/routes/auth_guard.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_firebase_auth.dart';
import 'package:get/get.dart';

void main() {
  test("AuthGuard redirects when user is null", () {
    final guard = AuthGuard();
    final mockAuth = MockFirebaseAuth();

    when(mockAuth.currentUser).thenReturn(null);

    final result = guard.redirect("/home");

    expect(result, "/login");
  });
}
