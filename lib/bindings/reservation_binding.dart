import 'package:parking/screens/reservation/reservation_controller.dart';
import 'package:get/get.dart';

class ReservationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservationController>(() => ReservationController());
  }
}
