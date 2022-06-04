import 'package:parking/const/text.dart';
import 'package:parking/models/carspot.dart';
import 'package:parking/widgets/snack_bar.dart';
import 'package:parking/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationController extends GetxController {
  var inProgress = false;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  List<Carspot> parking = [];
  late var uid;

  void reserveSpot(index) {
    if (parking[index].isSelected) {
      getErrorSnackBar(
          title: "Erreur", message: "This spot is already reserved");
    } else {
      update();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Spot reservation",
                style: AppTextStyle.smallBoldText),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Voulez-vous réserver ce spot ?",
                    style: AppTextStyle.tinyBoldText,
                  ),
                  const SizedBox(height: 40),
                  AppTextField(
                    label: "Date",
                    hint: "Date de réservation",
                    editingController: dateController,
                    validator: (value) {
                      if (value == "") {
                        return "Veuillez entrer une date";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    label: "Time",
                    hint: "Temps de réservation",
                    editingController: timeController,
                    validator: (value) {
                      if (value == "") {
                        return "Veuillez entrer un temps exact";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok', style: AppTextStyle.tinyBoldBlueText),
                onPressed: () async {
                  if (dateController.text == "" || timeController.text == "") {
                    getErrorSnackBar(
                        title: "Erreur",
                        message: "Veuillez remplir tous les champs");
                  } else {
                    try {
                      print("reserving");
                      //parking[index].isSelected = true;

                      //updating the spots
                      var collection =
                          FirebaseFirestore.instance.collection('parking');
                      collection.doc("spots").update({
                        "${index + 1}": true,
                      });

                      getParkingSpots();

                      print(uid);
                      //adding the reservation for the user history
                      FirebaseFirestore.instance
                          .collection("reservation")
                          .doc(uid)
                          .set({
                        dateController.text: {
                          "reservationDate": dateController.text,
                          "reservationTime": timeController.text,
                          "spotId": index + 1,
                        }
                      }, SetOptions(merge: true));

                      dateController.text = "";
                      timeController.text = "";
                      getSuccessSnackBar(
                          title: "Succès",
                          message: "Votre réservation a été enregistrée");
                      Navigator.of(context).pop();
                    } catch (e) {
                      print(e.toString());
                    }
                    update();
                  }
                },
              ),
              TextButton(
                child:
                    const Text('Cancel', style: AppTextStyle.tinyBoldBlueText),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    uid = Get.arguments;
    getParkingSpots();
  }

  void getParkingSpots() async {
    DocumentSnapshot spots = await FirebaseFirestore.instance
        .collection("parking")
        .doc("spots")
        .get();

    parking = [
      Carspot(isleft: false, isSelected: spots['1']),
      Carspot(isleft: true, isSelected: spots['2']),
      Carspot(isleft: false, isSelected: spots['3']),
      Carspot(isleft: true, isSelected: spots['4']),
      Carspot(isleft: false, isSelected: spots['5']),
      Carspot(isleft: true, isSelected: spots['6']),
      Carspot(isleft: false, isSelected: spots['7']),
      Carspot(isleft: true, isSelected: spots['8']),
    ];

    update();
  }
}
