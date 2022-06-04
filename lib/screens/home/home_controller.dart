import 'package:parking/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late var uid;
  String name = "";

  @override
  void onInit() async {
    super.onInit();
    uid = Get.arguments;
    await getDataByUid();
    update();
  }

  getDataByUid() async {
    print(uid);
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection("user-data").doc(uid).get();
    name = variable["firstName"];
    update();
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.toNamed(Routes.signin);
    } catch (e) {}
  }
}
