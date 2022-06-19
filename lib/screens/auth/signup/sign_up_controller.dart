import 'package:parking/routes/app_routes.dart';
import 'package:parking/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController matriculeController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  var bd;
  late FirebaseAuth auth;
  bool inProgress = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  void signUp() async {
    inProgress = true;
    update();
    try {
      //Sign up service
      var email = emailController.text;
      var password = passwordController.text;
      var confirmPassword = confirmPasswordController.text;
      var firstName = firstNameController.text;
      var lastName = lastNameController.text;
      var phoneNumber = phoneNumberController.text;
      var matricule = matriculeController.text;
      var brand = brandController.text;
      var color = colorController.text;

      //firebase auth
      if (password == confirmPassword) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        FirebaseFirestore.instance
            .collection("user-data")
            .doc(userCredential.user!.uid)
            .set({
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "phoneNumber": phoneNumber,
          "matricule": matricule,
          "brand": brand,
          "color": color,
        });

        emailController.text = "";
        passwordController.text = "";
        confirmPasswordController.text = "";
        firstNameController.text = "";
        lastNameController.text = "";
        phoneNumberController.text = "";
        matriculeController.text = "";
        brandController.text = "";
        colorController.text = "";
        formKey.currentState!.reset();

        Get.toNamed(Routes.home, arguments: {
          "uid": userCredential.user!.uid,
          "email": email,
        });
      } else {
        getErrorSnackBar(
            title: "Erreur",
            message: "Les mots de passe ne sont pas identiques");
      }
    } catch (e) {
      getErrorSnackBar(title: "Erreur", message: e.toString());
    } finally {
      inProgress = false;
    }
    update();
  }
}
