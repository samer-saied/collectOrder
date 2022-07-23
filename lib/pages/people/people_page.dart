import 'package:collect_order/controller/main_controller.dart';
import 'package:collect_order/core/appcolors.dart';
import 'package:collect_order/core/appwidgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'people_collect_page.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    var size = MediaQuery.of(context).size;
    GlobalKey scaffold = GlobalKey();

    return Scaffold(
      key: scaffold,
      backgroundColor: whiteColor,
      appBar: customAppBar(context, "Friends".tr),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///////// Image //////////////
            Obx(
              () => Expanded(
                child: CustomImage(
                  stringImage: mainController.peopleNumber.value == 1
                      ? "assets/images/characters/p1.png"
                      : mainController.peopleNumber.value == 2
                          ? "assets/images/people2person.png"
                          : "assets/images/people3person.png",
                  height: size.width / 2,
                  width: size.width / 2,
                ),
              ),
            ),
            ///////// people //////////////
            Expanded(
                child: Column(
              children: [
                ///////// person Numbers //////////////
                CustomText(
                  txt: "Number Of Friends".tr,
                  color: mainColor,
                  size: 30,
                ),
                ///////// + 1 - //////////////
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => {mainController.decrementPeople()},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: mainColor, shape: BoxShape.circle),
                          child: const Icon(
                            FontAwesomeIcons.minus,
                            color: whiteColor,
                          ),
                        ),
                      ),
                      Obx(
                        () => CustomText(
                          txt: mainController.peopleNumber.string,
                          color: mainColor,
                          size: 40,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          mainController.incrementPeople();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: mainColor, shape: BoxShape.circle),
                          child: const Icon(
                            FontAwesomeIcons.plus,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
            ///////// Next //////////////
            CustomButton(
              txt: 'Next'.tr,
              width: MediaQuery.of(context).size.width - 50,
              onpressedFunc: () => {Get.to(() => const PeopleCollectPage())},
            ),
            ///////// Spacer //////////////
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
