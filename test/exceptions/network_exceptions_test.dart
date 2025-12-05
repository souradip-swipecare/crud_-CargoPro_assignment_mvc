import 'package:flutter_test/flutter_test.dart';
import 'package:assignmettask/exceptions/network_exceptions.dart';

void main() {
  test("Network exception converts timeout", () {
    final error = NetworkExceptions.handle("timeout");
    expect(error, contains("Request timed out"));
  });
}
