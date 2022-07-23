import 'package:collect_order/controller/main_controller.dart';
import 'package:collect_order/core/appcolors.dart';
import 'package:collect_order/core/appwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../users/erver_user_page.dart';

class ProductsCollectPage extends StatelessWidget {
  const ProductsCollectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    // print(mainController.products.length.toString() + "-------Here--------");
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(context, "Products".tr),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              ///////////// Insert Products Text /////////////
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: CustomText(
                    txt: "Insert Products which you want to Buy ...".tr,
                    color: mainColor,
                    size: 24),
              ),
              ///////////// ListView of Products /////////////
              Obx(
                (() => Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: mainController.products.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          ///////////////////////     Empty Widget    ///////////////////////
                          if (mainController.products.isEmpty) {
                            return GetEmptyProductWidget(
                              index: index,
                            );
                          }
                          // ignore: invalid_use_of_protected_member
                          ///////////////////////     last Widget + add product  ///////////////////////
                          if (index == mainController.products.length) {
                            // mainController.createOrderList();

                            return GetAddProductWidget(
                              index: index,
                            );
                          } else {
                            ///////////////////////     List Widget    ///////////////////////
                            List<dynamic> products = mainController.products;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  padding: const EdgeInsets.only(right: 5),
                                  color: main2Color,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Remove".tr,
                                        style: const TextStyle(
                                          color: whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Confirm".tr),
                                        content: Text(
                                            "Are you sure to delete this product?"
                                                .tr),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                mainController.removeToProducts(
                                                    index: index);
                                                // mainController
                                                //     .createOrderList();

                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text(
                                                "DELETE".tr,
                                                style: const TextStyle(
                                                    color: main2Color),
                                              )),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: Text(
                                              "CANCEL".tr,
                                              style: const TextStyle(
                                                  color: mainColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                key: UniqueKey(),
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
                                      CustomText(
                                        color: mainColor,
                                        txt:
                                            "${index + 1} - ${products[index].title}",
                                        size: 20,
                                      ),
                                      CustomText(
                                        color: secandColor,
                                        txt:
                                            '${'Price'.tr} : ${products[index].price}',
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    )),
              ),
              ///////////// Next Button /////////////
              Obx((() {
                return mainController.products.isEmpty
                    ? const SizedBox()
                    : CustomButton(
                        txt: "Next".tr,
                        width: MediaQuery.of(context).size.width - 50,
                        onpressedFunc: () async {
                          await mainController.createOrderList();

                          if (mainController.ordersDetails.isNotEmpty) {
                            Get.to(() => const EveryUserPage(
                                  userIndex: 0,
                                ));
                          } else {
                            Get.snackbar("Error", "Error PCP0180");
                          }
                        },
                      );
              })),
              ///////// Spacer //////////////
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetAddProductWidget extends StatelessWidget {
  final int index;
  const GetAddProductWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return GetAlertDialogWidget(index: index);
        },
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle,
              color: main2Color,
              size: 26,
            ),
            const SizedBox(
              width: 5,
            ),
            CustomText(txt: "add another".tr, color: main2Color, size: 20),
          ],
        ),
      ),
    );
  }
}

class GetEmptyProductWidget extends StatelessWidget {
  final int index;

  const GetEmptyProductWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 150,
              stringImage: "assets/images/empty-cart.png"),
          const SizedBox(
            height: 10,
          ),
          CustomText(txt: "No products added".tr, color: secandColor, size: 18),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => showDialog(
                context: context,
                builder: (context) => GetAlertDialogWidget(index: index)),
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: main2Color,
                    width: 1,
                  )),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                      txt: "add product".tr, color: main2Color, size: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class GetAlertDialogWidget extends StatefulWidget {
  int index;
  GetAlertDialogWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<GetAlertDialogWidget> createState() => _GetAlertDialogWidgetState();
}

class _GetAlertDialogWidgetState extends State<GetAlertDialogWidget> {
  MainController mainController = Get.find<MainController>();

  TextEditingController nameTxtCntrl = TextEditingController();

  TextEditingController pricTxtCntrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FocusNode focusItem1 = FocusNode();

  FocusNode focusItem2 = FocusNode();

  @override
  void dispose() {
    nameTxtCntrl.dispose();
    pricTxtCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Add Product".tr),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: nameTxtCntrl,
                  focusNode: focusItem1,
                  keyboardType: TextInputType.text,
                  cursorColor: mainColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name Ex:Chicken'.tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    iconColor: mainColor,
                    labelStyle: const TextStyle(
                      color: mainColor,
                    ),
                    focusedBorder: const UnderlineInputBorder(),
                    icon: const Icon(FontAwesomeIcons.box, color: mainColor),
                    labelText: 'Name'.tr,
                  ),
                ),
                TextFormField(
                  controller: pricTxtCntrl,
                  focusNode: focusItem2,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  cursorColor: mainColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product price Ex:25.0'.tr;
                    }
                    return null;
                  },
                  // obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                      color: mainColor,
                    ),
                    hintStyle: const TextStyle(
                      color: mainColor,
                    ),
                    iconColor: mainColor,
                    focusedBorder: const UnderlineInputBorder(),
                    icon: const Icon(FontAwesomeIcons.moneyBill1,
                        color: mainColor),
                    labelText: 'Price'.tr,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          DialogButton(
            color: main2Color,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                mainController.insertToProducts(
                    index: widget.index,
                    productTitle: nameTxtCntrl.value.text.toString(),
                    productPrice: pricTxtCntrl.value.text.toString());
              }
              widget.index = widget.index + 1;
              nameTxtCntrl.clear();
              pricTxtCntrl.clear();
              focusItem1.requestFocus();
            },
            child: Text(
              "add another".tr,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          DialogButton(
            color: mainColor,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ///
                ///
                ///
                /// add products after insert to products list TO current Order details
                ///
                ///
                ///

                mainController.insertToProducts(
                    index: widget.index,
                    productTitle: nameTxtCntrl.value.text.toString(),
                    productPrice: pricTxtCntrl.value.text.toString());
              }

              Get.back();
            },
            child: Text(
              "Done".tr,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]);
  }
}

///
///
///
///
///

// Future<bool?> getAlertWidget(context, index) {
//   MainController mainController = Get.find<MainController>();
//   TextEditingController nameTxtCntrl = TextEditingController();
//   TextEditingController pricTxtCntrl = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   FocusNode focusItem1 = FocusNode();
//   FocusNode focusItem2 = FocusNode();

//   return Alert(
//       context: context,
//       title: "add Products".tr,
//       content: Form(
//         key: formKey,
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               controller: nameTxtCntrl,
//               focusNode: focusItem1,
//               keyboardType: TextInputType.text,
//               cursorColor: mainColor,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter product name Ex:Chicken'.tr;
//                 }
//                 return null;
//               },
//               decoration: InputDecoration(
//                 iconColor: mainColor,
//                 labelStyle: const TextStyle(
//                   color: mainColor,
//                 ),
//                 focusedBorder: const UnderlineInputBorder(),
//                 icon: const Icon(FontAwesomeIcons.box, color: mainColor),
//                 labelText: 'Name'.tr,
//               ),
//             ),
//             TextFormField(
//               controller: pricTxtCntrl,
//               focusNode: focusItem2,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//               ],
//               cursorColor: mainColor,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter product price Ex:25.0'.tr;
//                 }
//                 return null;
//               },
//               // obscureText: true,
//               decoration: InputDecoration(
//                 labelStyle: const TextStyle(
//                   color: mainColor,
//                 ),
//                 hintStyle: const TextStyle(
//                   color: mainColor,
//                 ),
//                 iconColor: mainColor,
//                 focusedBorder: const UnderlineInputBorder(),
//                 icon: const Icon(FontAwesomeIcons.moneyBill1, color: mainColor),
//                 labelText: 'Price'.tr,
//               ),
//             ),
//           ],
//         ),
//       ),
//       buttons: [
//         DialogButton(
//           color: main2Color,
//           onPressed: () {
//             if (formKey.currentState!.validate()) {
//               mainController.insertToProducts(
//                   index: index,
//                   productTitle: nameTxtCntrl.value.text.toString(),
//                   productPrice: pricTxtCntrl.value.text.toString());
//             }
//             index = index + 1;
//             nameTxtCntrl.clear();
//             pricTxtCntrl.clear();
//             focusItem1.requestFocus();
//           },
//           child: Text(
//             "add another".tr,
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//           ),
//         ),
//         DialogButton(
//           color: mainColor,
//           onPressed: () {
//             if (formKey.currentState!.validate()) {
//               ///
//               ///
//               ///
//               /// add products after insert to products list TO current Order details
//               ///
//               ///
//               ///

//               mainController.insertToProducts(
//                   index: index,
//                   productTitle: nameTxtCntrl.value.text.toString(),
//                   productPrice: pricTxtCntrl.value.text.toString());
//             }

//             Get.back();
//           },
//           child: Text(
//             "Done".tr,
//             style: const TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       ]).show();
// }
