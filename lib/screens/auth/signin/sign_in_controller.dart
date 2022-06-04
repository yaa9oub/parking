import 'package:parking/routes/app_routes.dart';
import 'package:parking/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool inProgress = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  void signIn() async {
    inProgress = true;
    update();
    try {
      //Sign in service
      var email = emailController.text;
      var password = passwordController.text;

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);

      Get.offAllNamed(Routes.home, arguments: userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        getErrorSnackBar(
            title: "Parking",
            message: 'Aucun utilisateur trouvé pour cet e-mail.');
      } else if (e.code == 'wrong-password') {
        getErrorSnackBar(
            title: "Parking",
            message: 'Mauvais mot de passe fourni pour cet utilisateur.');
      } else {
        getErrorSnackBar(title: "Parking", message: e.toString());
      }
    } finally {
      inProgress = false;
      emailController.text = "";
      passwordController.text = "";
      update();
    }
  }
}
