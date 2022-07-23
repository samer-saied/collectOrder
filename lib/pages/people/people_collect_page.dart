import 'package:collect_order/controller/main_controller.dart';
import 'package:collect_order/core/appcolors.dart';
import 'package:collect_order/core/appwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../products/products_collect_page.dart';

class PeopleCollectPage extends StatelessWidget {
  const PeopleCollectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(context, "Friends' Names".tr),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                    txt: "Insert friends Name".tr, color: mainColor, size: 24),
              ),
              Expanded(
                  child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: mainController.peopleNumber.value,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (mainController.peopleNumber.value == 1) ? 1 : 2),
                itemBuilder: (BuildContext context, int index) {
                  int indexPic = mainController.getPicNumber(index + 1);
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomImage(
                            stringImage:
                                "assets/images/characters/p$indexPic.png",
                            height: 100,
                            width:
                                (MediaQuery.of(context).size.width * 0.8) / 2,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hintTxt: "Enter a name".tr,
                          index: index,
                          initTxt: mainController.people.length !=
                                  mainController.peopleNumber.value
                              ? "${"Friend".tr} ${index + 1}"
                              : mainController.people[index],
                        ),
                      ],
                    ),
                  );
                },
              )),
              CustomButton(
                txt: 'Next'.tr,
                width: MediaQuery.of(context).size.width - 50,
                onpressedFunc: () {
                  if (mainController.people.isEmpty ||
                      mainController.people.length !=
                          mainController.peopleNumber.value) {
                    mainController.fillListWithTempData(
                        tempList: mainController.people,
                        listLength: mainController.peopleNumber.value,
                        listTitle: "Friend".tr);
                    Get.to(() => const ProductsCollectPage());
                  } else {
                    Get.to(() => const ProductsCollectPage());
                  }
                },
              ),
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

//////////////////   CUSTOM FORM FIELD     //////////////////
class CustomTextField extends StatefulWidget {
  final int index;
  final String hintTxt;
  final String initTxt;
  const CustomTextField({
    Key? key,
    required this.hintTxt,
    required this.index,
    required this.initTxt,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController txtController = TextEditingController();
  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mainController = Get.find<MainController>();
    return TextFormField(
        onChanged: (value) {
          if (value.isEmpty) {
            mainController.insertToPeople(
                value: "${"Friend".tr} ${widget.index + 1}",
                index: widget.index);
          } else {
            mainController.insertToPeople(value: value, index: widget.index);
          }
        },
        cursorColor: mainColor,
        // initialValue: widget.initTxt,
        controller: txtController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(right: 10.0, left: 10.0),
          fillColor: whiteColor,
          focusColor: mainColor,
          filled: true,
          hintText: widget.hintTxt,
          hintStyle: const TextStyle(color: mainColor),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: mainColor,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: main2Color,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ));
  }
}
