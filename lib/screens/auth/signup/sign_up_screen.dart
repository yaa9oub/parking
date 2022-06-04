import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:parking/routes/app_routes.dart';
import 'package:parking/screens/auth/signup/sign_up_controller.dart';
import 'package:parking/widgets/buttons.dart';
import 'package:parking/widgets/date_picker.dart';
import 'package:parking/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var xSpace = 10.0;
    var ySpace = 20.0;
    return Scaffold(
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
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
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      //Title
                      const Text("Welcome!!", style: AppTextStyle.bigBoldText),
                      const SizedBox(
                        height: 5,
                      ),
                      //Subtitle
                      const Text("Sign up with your email and password!!",
                          style: AppTextStyle.tinyThinText),
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
                              editingController: controller.firstNameController,
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
                              editingController: controller.lastNameController,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Tel
                          SizedBox(
                            width: size.width * 0.45,
                            child: AppTextField(
                              label: "Phone number",
                              hint: "+216 99 696 969",
                              borderRadius: 0,
                              inputType: TextInputType.phone,
                              iconData: Icons.phone,
                              editingController:
                                  controller.phoneNumberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "phone number is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          //mat
                          SizedBox(
                            width: size.width * 0.45,
                            child: AppTextField(
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
                          ),
                        ],
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
                      //Email
                      AppTextField(
                        label: "Email",
                        hint: "email@email.com",
                        iconData: Icons.email,
                        inputType: TextInputType.emailAddress,
                        borderRadius: 0,
                        editingController: controller.emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email is required";
                          }
                          return null;
                        },
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
                      SizedBox(
                        height: ySpace,
                      ),
                      //Password
                      AppTextField(
                        label: "Confirm password",
                        hint: "",
                        iconData: Icons.password,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                        borderRadius: 0,
                        editingController: controller.confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ySpace,
                      ),
                      //Date picker
                      DatePicker(
                        borderRadius: 0,
                        bgColor: AppColors.lightGray.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: ySpace,
                      ),
                      //Button
                      PrimaryButton(
                        title: "Sign Up",
                        borderRadius: 5,
                        processing: controller.inProgress,
                        onClick: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.signUp();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Want to sign in?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Do you have an account already?",
                            style: AppTextStyle.tinyThinText,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.signin);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 10.0),
                              child: Text(
                                " Sign in",
                                style: AppTextStyle.tinyBoldBlueText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
