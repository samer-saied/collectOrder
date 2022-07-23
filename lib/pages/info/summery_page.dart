import 'package:collect_order/models/order_model.dart';
import 'package:collect_order/pages/home/home_page.dart';
import 'package:collect_order/pages/users/erver_user_summery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controller/main_controller.dart';
import '../../core/ads/ad_banner_widget.dart';
import '../../core/appcolors.dart';
import '../../core/appwidgets.dart';

class SummeryPage extends StatelessWidget {
  final OrderModel currentOrder;
  final bool btnAvailable;

  const SummeryPage(
      {super.key, required this.currentOrder, required this.btnAvailable});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    // TextEditingController feesTxtCntrl = btnAvailable
    //     ? TextEditingController(text: "0")
    //     : TextEditingController(text: mainController.orderFees.toString());

    return Scaffold(
      appBar: AppBar(
        title: CustomText(txt: "Summery Order".tr, color: whiteColor, size: 24),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          // ignore: unnecessary_null_comparison
          child: currentOrder == null || currentOrder.id.isEmpty
              ? Center(child: angeryPersonWidget(context, 'No Data'))
              : Column(
                  children: [
                    ///////
                    ///
                    ///
                    ///
                    ///
                    /////////////     Products      /////////////
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CustomText(
                            color: secandColor,
                            txt: 'Products'.tr,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: currentOrder.details[0].items!.length,
                      itemBuilder: (context, index) => Container(
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
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            CustomText(
                              color: mainColor,
                              txt:
                                  "${index + 1} - ${currentOrder.details[0].items![index].title}",
                              size: 20,
                            ),
                            CustomText(
                              color: secandColor,
                              txt:
                                  "${"Quntity".tr} : ${mainController.getProductNumbers(currentOrder, index)}",
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ///////
                    ///
                    ///
                    ///
                    ///
                    /////////////     USERS      /////////////
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CustomText(
                            color: secandColor,
                            txt: 'Users'.tr,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: currentOrder.details.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => EveryUserSummeryPage(
                                    orderDetailsModel:
                                        currentOrder.details[index],
                                    userIndex: index,
                                  ));
                            },
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  //////////
                                  //////////
                                  //////////
                                  //////////   mainController.getPicNumber(index)
                                  CustomImage(
                                      width: 30,
                                      height: 30,
                                      stringImage:
                                          "assets/images/characters/p${mainController.getPicNumber(index + 1)}.png"),
                                  CustomText(
                                    color: mainColor,
                                    txt: currentOrder.details[index].user
                                        .toString(),
                                    size: 20,
                                  ),
                                  CustomText(
                                    color: secandColor,
                                    txt:
                                        "${"Total".tr} : ${currentOrder.details[index].getMoneyTotal()}",
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ///////
                    ///
                    ///
                    ///
                    ///
                    /////////////     FEES      /////////////
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CustomText(
                            color: secandColor,
                            txt: 'Fees'.tr,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(5),
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
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  readOnly: btnAvailable ? false : true,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  initialValue: btnAvailable
                                      ? "0"
                                      : currentOrder.fees.toString(),
                                  cursorColor: secandColor,
                                  keyboardType: TextInputType.number,
                                  onChanged: (newData) {},
                                  onFieldSubmitted: (newData) {
                                    mainController.changeFeesValue(newData);
                                    /////////////////////
                                    ///
                                    ///
                                    ///
                                    /////////////////////
                                  },
                                  cursorHeight: 26,
                                  style: const TextStyle(
                                      color: secandColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        )),

                    ///////
                    ///
                    ///
                    ///
                    ///
                    /////////////     Total      /////////////
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          CustomText(
                            color: secandColor,
                            txt: 'Total'.tr,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                      child: Center(
                        child: CustomText(
                          color: main2Color,
                          size: 22,
                          ////////
                          ///
                          ///
                          /// + double.tryParse(mainController.orderFees) ?? 0.0)
                          txt: btnAvailable
                              ? "${currentOrder.getAllTotalFees()} ${mainController.selectedCurrency!.tr.toUpperCase()}"
                              : "${currentOrder.getAllTotalFees()} ${mainController.selectedCurrency!.tr.toUpperCase()}",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ///////
                    ///
                    ///
                    ///
                    ///
                    /////////////     Button      /////////////
                    btnAvailable
                        ? CustomButton(
                            txt: 'Save'.tr,
                            width: MediaQuery.of(context).size.width - 50,
                            onpressedFunc: () {
                              ///
                              ///
                              ///
                              ///
                              ///   Edit HERE
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              ///
                              // mainController.resetData();
                              mainController.saveCurrentOrderToHistory();
                              mainController.resetData();
                              Get.offAll(() => HomePage());
                            },
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                    ///////// Spacer //////////////
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.01,
                    // ),
                    const AddBannerWidget(),
                  ],
                ),
        ),
      ),
    );
  }
}
