import 'package:parking/bindings/boarding_binding.dart';
import 'package:parking/bindings/hisotry_binding.dart';
import 'package:parking/bindings/home_binding.dart';
import 'package:parking/bindings/profile_binding.dart';
import 'package:parking/bindings/reservation_binding.dart';
import 'package:parking/bindings/sign_in_binding.dart';
import 'package:parking/bindings/sign_up_binding.dart';
import 'package:parking/bindings/splash_binding.dart';
import 'package:parking/screens/auth/signin/sign_in_screen.dart';
import 'package:parking/screens/auth/signup/sign_up_screen.dart';
import 'package:parking/screens/history/history_screen.dart';
import 'package:parking/screens/home/home_screen.dart';
import 'package:parking/screens/onboardingscreen/boarding_screen.dart';
import 'package:parking/screens/profile/profile_screen.dart';
import 'package:parking/screens/reservation/reservation_screen.dart';
import 'package:parking/screens/splashscreen/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.signin,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.boarding,
      page: () => const BoardingPage(),
      binding: BoardingBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.reservation,
      page: () => const ReservationPage(),
      binding: ReservationBinding(),
    ),
    GetPage(
      name: Routes.history,
      page: () => const HistoryPage(),
      binding: HistoryBinding(),
    ),
  ];
}
