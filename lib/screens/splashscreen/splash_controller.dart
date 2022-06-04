import 'package:parking/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigate();
    super.onInit();
  }

  Future navigate() async {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      checkAuth();
    });
  }

  checkAuth() async {
    var currentUser = await FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Get.offAllNamed(Routes.home, arguments: currentUser.uid);
    } else {
      Get.offAllNamed(Routes.signin);
    }
  }
}
