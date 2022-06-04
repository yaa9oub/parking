import 'package:get/get.dart';
import 'package:parking/screens/onboardingscreen/boarding_controller.dart';

class BoardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardingController>(() => BoardingController());
  }
}
