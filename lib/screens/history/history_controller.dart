import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:parking/widgets/date_picker.dart';
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

  static var date = "Pick ur date", time = "Pick your Time";

  @override
  void onInit() {
    super.onInit();
    uid = Get.arguments;
    getReservations();
  }

  void changeReservation(index) {
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
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Do you want to modify this reservation ?",
                  style: AppTextStyle.tinyBoldText,
                ),
                const SizedBox(height: 40),
                const Text(
                  "Date",
                  style: AppTextStyle.tinyThinText,
                ),
                const SizedBox(
                  height: 8,
                ),
                DatePicker(
                  bgColor: AppColors.gray.withOpacity(0.1),
                  isTime: false,
                  value: date,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Time",
                  style: AppTextStyle.tinyThinText,
                ),
                const SizedBox(
                  height: 8,
                ),
                DatePicker(
                  bgColor: AppColors.gray.withOpacity(0.1),
                  isTime: true,
                  value: time,
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

                  print("Date : " + date + "  time : " + time);

                  //updating
                  FirebaseFirestore.instance
                      .collection("reservation")
                      .doc(uid)
                      .update({
                    date + time: {
                      "reservationDate": date,
                      "reservationTime": time,
                      "spotId": reservations[index].slot,
                    }
                  });

                  //delete
                  FirebaseFirestore.instance
                      .collection('reservation')
                      .doc(uid)
                      .set(
                    {
                      reservations[index].date + reservations[index].time:
                          FieldValue.delete()
                    },
                    SetOptions(
                      merge: true,
                    ),
                  );

                  getReservations();

                  Navigator.of(context).pop();
                  update();
                }
              },
            ),
            TextButton(
              child: const Text('Cancel', style: AppTextStyle.tinyBoldBlueText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

                  //updating the spots
                  var collection =
                      FirebaseFirestore.instance.collection('parking');
                  collection.doc("spots").update({
                    reservations[index].slot: false,
                  });

                  //deleting
                  FirebaseFirestore.instance
                      .collection('reservation')
                      .doc(uid)
                      .set(
                    {
                      reservations[index].date + reservations[index].time:
                          FieldValue.delete()
                    },
                    SetOptions(
                      merge: true,
                    ),
                  );
                  getReservations();
                  update();
                  Navigator.of(context).pop();
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

  void getReservations() async {
    try {
      reservations = [];
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
