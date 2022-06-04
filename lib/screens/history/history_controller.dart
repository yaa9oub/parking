import 'package:parking/const/text.dart';
import 'package:parking/widgets/snack_bar.dart';
import 'package:parking/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  //Resevation status :
  //true : reserved and done
  //false : reserved but didn't happen yet

  late var uid;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  List<Reservation> reservations = [];

  void changeReservation(index) {
    if (reservations[index].status) {
      getErrorSnackBar(
          title: "Erreur",
          message:
              "You can not change this spot! because the reservation is ongoing.");
    } else {
      dateController.text = reservations[index].date;
      timeController.text = reservations[index].time;
      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Modify reservation",
                style: AppTextStyle.smallBoldText),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Do you want to modify this reservation ?",
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
                onPressed: () {
                  if (dateController.text == "" || timeController.text == "") {
                    getErrorSnackBar(
                        title: "Erreur",
                        message: "Veuillez remplir tous les champs");
                  } else {
                    getSuccessSnackBar(
                        title: "Succès",
                        message: "Votre réservation a été enregistrée");
                    reservations[index].status = true;
                    Navigator.of(context).pop();
                    dateController.text = "";
                    timeController.text = "";
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

  void cancelReservation(index) {
    if (reservations[index].status) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text("Cancel reservation",
                style: AppTextStyle.smallBoldText),
            content: const Text(
              "Do you want to cancel this reservation ?",
              style: AppTextStyle.tinyBoldText,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok', style: AppTextStyle.tinyBoldBlueText),
                onPressed: () {
                  getSuccessSnackBar(
                      title: "Succès",
                      message: "Votre réservation a été annulée");
                  reservations[index].status = false;
                  Navigator.of(context).pop();
                  update();
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
    } else {
      getErrorSnackBar(
          title: "Erreur", message: "You can not cancel this reservation.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    uid = Get.arguments;
    getReservations();
  }

  void getReservations() async {
    try {
      //print(uid);
      await FirebaseFirestore.instance
          .collection("reservation")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          if (result.id == uid) {
            result.data().forEach(
              (key, value) {
                reservations.add(
                  Reservation(
                    date: value["reservationDate"].toString(),
                    time: value["reservationTime"].toString(),
                    status: true,
                    slot: value["spotId"].toString(),
                  ),
                );
              },
            );
          } else {
            reservations = [];
          }
        });
      });
      update();
    } catch (e) {
      print(e);
    }
  }
}

class Reservation {
  String date;
  String time;
  String slot;
  bool status;

  Reservation(
      {required this.date,
      required this.time,
      required this.slot,
      required this.status});
}
