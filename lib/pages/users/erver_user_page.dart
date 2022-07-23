import 'package:collect_order/core/appcolors.dart';
import 'package:collect_order/core/appwidgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';
import '../../core/ads/ad_banner_widget.dart';
import '../info/summery_page.dart';

class EveryUserPage extends StatelessWidget {
  final int userIndex;
  const EveryUserPage({Key? key, required this.userIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    var currentOrder = mainController.ordersDetails[userIndex];
    var partOneSize = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      key: UniqueKey(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25),
            height: partOneSize,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ////////////////////////  BackButton   ////////////////////////
                const BackButton(color: whiteColor),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ////////////////////////  Image   ////////////////////////
                    CustomImage(
                        width: 75,
                        height: partOneSize - 30,
                        stringImage:
                            "assets/images/characters/p${mainController.getPicNumber(userIndex + 1)}.png"),
                    ////////////////////////  Name-Total   ////////////////////////
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              txt: currentOrder.user!.capitalize.toString(),
                              color: whiteColor,
                              size: 24),
                          GetBuilder<MainController>(
                            builder: (controller) => CustomText(
                                txt:
                                    "${"Items".tr} : ${controller.ordersDetails[userIndex].getQuntityTotal()}",
                                color: whiteColor,
                                size: 18),
                          ),
                          GetBuilder<MainController>(
                              builder: (controller) => CustomText(
                                  txt:
                                      "${"Total".tr} : ${controller.ordersDetails[userIndex].getMoneyTotal()}",
                                  color: whiteColor,
                                  size: 18))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Obx(
            (() {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemCount: mainController
                        .products.length, //currentOrder.items.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: ((context, index) => Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(5, 2),
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 5,
                                    spreadRadius: 0.5)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // alignment: WrapAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: CustomText(
                                  color: mainColor,
                                  txt: mainController.products[index].title,
                                  size: 20,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  mainController.incrementQuntity(
                                      userIndex, index);

                                  // mainController.getOrderItemsNumber(userIndex);
                                  // mainController.getOrderItemsTotal(userIndex);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: mainColor, shape: BoxShape.circle),
                                  child: const Icon(
                                    FontAwesomeIcons.plus,
                                    color: whiteColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                              GetBuilder<MainController>(builder: (controller) {
                                ///
                                ///
                                ///
                                ///
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: CustomText(
                                    color: secandColor,
                                    txt: controller
                                        .ordersDetails[userIndex].quntity[index]
                                        .toString(),
                                    size: 26,
                                  ),
                                );
                              }),
                              InkWell(
                                onTap: () {
                                  mainController.decrementQuntity(
                                      userIndex, index);
                                  // mainController.getOrderItemsNumber(userIndex);
                                  // mainController.getOrderItemsTotal(userIndex);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: mainColor, shape: BoxShape.circle),
                                  child: const Icon(
                                    FontAwesomeIcons.minus,
                                    color: whiteColor,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                  ),
                ),
              );
            }),
          ),
          CustomButton(
            txt: mainController.peopleNumber.value > userIndex + 1
                ? 'Next'.tr
                : 'Report'.tr,
            width: MediaQuery.of(context).size.width - 50,
            onpressedFunc: () {
              mainController.editOrderList(
                  userIndex, mainController.ordersDetails[userIndex].quntity);
              // ignore: unrelated_type_equality_checks
              if (mainController.peopleNumber != 0 &&
                  mainController.peopleNumber.value > userIndex + 1) {
                Get.to(
                    () => EveryUserPage(
                          userIndex: userIndex + 1,
                        ),
                    preventDuplicates: false);
              } else {
                // mainController.saveCurrentOrderToHistory();
                Get.to(() => SummeryPage(
                      currentOrder: mainController.currentOrder,
                      btnAvailable: true,
                    ));
              }
            },
          ),
          ///////// Spacer //////////////
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          const AddBannerWidget(),
        ],
      ),
    );
  }
}
