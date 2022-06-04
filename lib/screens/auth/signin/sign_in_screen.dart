import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:parking/routes/app_routes.dart';
import 'package:parking/screens/auth/signin/sign_in_controller.dart';
import 'package:parking/widgets/buttons.dart';
import 'package:parking/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var xSpace = 10.0;
    var ySpace = 20.0;
    return Scaffold(
      body: GetBuilder<SignInController>(
          init: SignInController(),
          initState: (_) {},
          builder: (controller) {
            return WillPopScope(
              onWillPop: () async => false,
              child: SafeArea(
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
                          const Text("Welcome back!!",
                              style: AppTextStyle.bigBoldText),
                          const SizedBox(
                            height: 5,
                          ),
                          //Subtitle
                          const Text("Sign in with your email and password!!",
                              style: AppTextStyle.tinyThinText),
                          const SizedBox(
                            height: 120,
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
                          //Button
                          PrimaryButton(
                            title: "Sign In",
                            borderRadius: 5,
                            processing: controller.inProgress,
                            onClick: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.signIn();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //Want to sign up?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Want to create an account?",
                                style: AppTextStyle.tinyThinText,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.signup);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 10.0),
                                  child: Text(
                                    " Sign up",
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
              ),
            );
          }),
    );
  }
}
