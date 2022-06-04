import 'package:parking/routes/app_routes.dart';
import 'package:parking/widgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var inProgress = false;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController matriculeController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  late var uid;

  @override
  void onInit() {
    super.onInit();
    uid = Get.arguments;
    setData();
  }

  void setData() async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection("user-data").doc(uid).get();
    firstNameController.text = variable["firstName"];
    lastNameController.text = variable["lastName"];
    phoneNumberController.text = variable["phoneNumber"];
    matriculeController.text = variable["matricule"];
    brandController.text = variable["brand"];
    colorController.text = variable["color"];
    passwordController.text = variable["password"];

    update();
  }

  void updateData() async {
    inProgress = true;
    update();
    var password = passwordController.text;
    var firstName = firstNameController.text;
    var lastName = lastNameController.text;
    var phoneNumber = phoneNumberController.text;
    var matricule = matriculeController.text;
    var brand = brandController.text;
    var color = colorController.text;

    try {
      var collection = FirebaseFirestore.instance.collection('user-data');
      collection.doc(uid).update({
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "matricule": matricule,
        "brand": brand,
        "color": color,
      });

      getSuccessSnackBar(title: "Parking", message: 'Mise à jour réussie !');

      passwordController.text = "";
      firstNameController.text = "";
      lastNameController.text = "";
      phoneNumberController.text = "";
      matriculeController.text = "";
      brandController.text = "";
      colorController.text = "";
      keyForm.currentState!.reassemble();

      Get.toNamed(Routes.home);
    } catch (e) {
      getErrorSnackBar(
          title: "Parking", message: 'Erreur lors de la mise à jour !');
    } finally {
      inProgress = false;
      update();
    }
  }
}
