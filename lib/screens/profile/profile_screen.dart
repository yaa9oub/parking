import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:parking/screens/profile/profile_controller.dart';
import 'package:parking/widgets/buttons.dart';
import 'package:parking/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var xSpace = 10.0;
    var ySpace = 20.0;
    return Scaffold(
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                color: AppColors.backgroundColor,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.keyForm,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        //Title
                        SizedBox(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Profile",
                                style: AppTextStyle.bigBoldText,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        //FIRST AND LAST NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //first name
                            SizedBox(
                              width: size.width * 0.45,
                              child: AppTextField(
                                label: "First name",
                                hint: "Foulen",
                                borderRadius: 0,
                                editingController:
                                    controller.firstNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "first name is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            //last name
                            SizedBox(
                              width: size.width * 0.45,
                              child: AppTextField(
                                label: "Last name",
                                hint: "Benfoulen",
                                borderRadius: 0,
                                editingController:
                                    controller.lastNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "last name is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ySpace,
                        ),
                        //TEL AND MATRICULE
                        AppTextField(
                          label: "Matricule",
                          hint: "69 6969",
                          borderRadius: 0,
                          editingController: controller.matriculeController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "matricule is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: ySpace,
                        ),
                        //BRAND AND COLOR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Brand
                            SizedBox(
                              width: size.width * 0.45,
                              child: AppTextField(
                                label: "Brand",
                                hint: "Fiat UNO",
                                borderRadius: 0,
                                editingController: controller.brandController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "brand is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            //Color
                            SizedBox(
                              width: size.width * 0.45,
                              child: AppTextField(
                                label: "Color",
                                hint: "Black",
                                borderRadius: 0,
                                editingController: controller.colorController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "color is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ySpace,
                        ),
                        //Password
                        AppTextField(
                          label: "Password",
                          hint: "Azerty.123",
                          iconData: Icons.password,
                          inputType: TextInputType.visiblePassword,
                          isPassword: true,
                          borderRadius: 0,
                          editingController: controller.passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        //Button
                        PrimaryButton(
                          title: "Soumettre",
                          processing: controller.inProgress,
                          borderRadius: 3,
                          onClick: () {
                            if (controller.keyForm.currentState!.validate()) {
                              controller.updateData();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
