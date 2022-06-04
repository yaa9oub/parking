import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:parking/routes/app_routes.dart';
import 'package:parking/screens/auth/signin/sign_in_controller.dart';
import 'package:parking/screens/home/home_controller.dart';
import 'package:parking/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Text(
                'MY-ISSATSO-PARKING',
                style: AppTextStyle.smallBoldWhiteText,
              ),
            ),
            ListTile(
              title: const Text(
                'Profile',
                style: AppTextStyle.smallBoldText,
              ),
              onTap: () {
                Get.toNamed(Routes.profile);
              },
            ),
            ListTile(
              title: const Text(
                'Reservation',
                style: AppTextStyle.smallBoldText,
              ),
              onTap: () {
                Get.toNamed(Routes.reservation);
              },
            ),
            ListTile(
              title: const Text(
                'History',
                style: AppTextStyle.smallBoldText,
              ),
              onTap: () {
                Get.toNamed(Routes.history);
              },
            ),
            ListTile(
              title: const Text(
                'Assistance',
                style: AppTextStyle.smallBoldText,
              ),
              onTap: () {
                UrlLauncher.launch("tel://99101001");
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Do you want to logout?'),
                      actions: [
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            controller.signOut();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
        title: const Text(
          'Home',
          style: AppTextStyle.smallBoldWhiteText,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.all(10),
                color: AppColors.secondaryColor.withOpacity(0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Title
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Text("Welcome back",
                              style: AppTextStyle.smallThinText),
                          const SizedBox(width: 10),
                          Text(
                            controller.name + " 😊😊",
                            style: AppTextStyle.smallBoldText,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    //menu
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Item(
                              title: "Profile",
                              icon: Icons.person,
                              height: 200,
                              width: 200,
                              onclick: () {
                                Get.toNamed(Routes.profile,
                                    arguments: controller.uid);
                              }),
                          Item(
                              title: "Reservation",
                              icon: Icons.calendar_today,
                              height: 200,
                              width: 200,
                              onclick: () {
                                Get.toNamed(Routes.reservation,
                                    arguments: controller.uid);
                              }),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Item(
                            title: "History",
                            icon: Icons.history,
                            height: 200,
                            width: 200,
                            onclick: () {
                              Get.toNamed(Routes.history,
                                  arguments: controller.uid);
                            }),
                        Item(
                            title: "Assistance",
                            icon: Icons.assistant,
                            height: 200,
                            width: 200,
                            onclick: () {
                              UrlLauncher.launch("tel://99101001");
                            }),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
