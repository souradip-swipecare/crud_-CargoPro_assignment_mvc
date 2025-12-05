import 'package:assignmettask/routes/approutes.dart';
import 'package:assignmettask/screens/auth/login_screen.dart';
import 'package:assignmettask/screens/auth/otp_screen.dart';
import 'package:assignmettask/screens/home/home_screen.dart';
import 'package:assignmettask/screens/home/object_detail_screen.dart';
import 'package:assignmettask/screens/home/object_form_screen.dart';
import 'package:assignmettask/screens/splash_screen.dart';
import 'package:get/get.dart';

import 'auth_guard.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashView()),
    GetPage(name: Routes.LOGIN, page: () => LoginView()),
    GetPage(name: Routes.OTP, page: () => OtpView()),

    // Protected Routes
    GetPage(
      name: Routes.OBJECT_FORM,
      page: () => ObjectFormView(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.HOME,
      page: () => ObjectListView(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.OBJECT_DETAIL,
      page: () => ObjectDetailView(),
      middlewares: [AuthGuard()],
    ),
  ];
}
