import 'package:collect_order/core/appcolors.dart';
import 'package:collect_order/core/appwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';
import '../../models/order_details_model.dart';

class EveryUserSummeryPage extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;
  final int userIndex;
  const EveryUserSummeryPage({
    Key? key,
    required this.orderDetailsModel,
    required this.userIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    var partOneSize = MediaQuery.of(context).size.height * 0.3;
    double total = 0;

    getTotalOrder() {
      for (var i = 0; i < orderDetailsModel.items!.length; i++) {
        total += (orderDetailsModel.quntity[i] *
            double.parse(orderDetailsModel.items![i].price));
      }
      return total;
    }

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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        ////////////////////////  BackButton   ////////////////////////
                        BackButton(color: whiteColor),
                      ],
                    ),
                    ////////////////////////  Image   ////////////////////////
                    CustomImage(
                        width: 75,
                        height: partOneSize / 3,
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
                                txt: orderDetailsModel.user
                                    .toString()
                                    .toUpperCase(),
                                color: whiteColor,
                                size: 24),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: orderDetailsModel.items!.length,
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
                              txt: orderDetailsModel.items![index].title,
                              size: 20,
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: CustomText(
                                color: secandColor,
                                txt: "${orderDetailsModel.quntity[index]} ",
                                size: 26,
                              )),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: CustomText(
                                color: secandColor,
                                txt: " x ",
                                size: 26,
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: CustomText(
                                color: secandColor,
                                txt: orderDetailsModel.items![index].price,
                                size: 26,
                              )),
                        ],
                      ),
                    )),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                color: mainColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // alignment: WrapAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomText(
                      color: main2Color,
                      txt: "${"Total".tr} : ",
                      size: 20,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomText(
                        color: whiteColor,
                        txt:
                            "${getTotalOrder()} ${mainController.selectedCurrency!.tr}",
                        size: 26,
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
