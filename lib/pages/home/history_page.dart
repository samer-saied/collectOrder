import 'package:collect_order/pages/people/people_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';
import '../../core/ads/ad_banner_widget.dart';
import '../../core/appcolors.dart';
import '../../core/appwidgets.dart';
import '../info/summery_page.dart';

// ignore: must_be_immutable
class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  MainController mainController = Get.put(MainController())
    ..getHistoryDatesTitles();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(txt: "History".tr, color: whiteColor, size: 24),
        actions: [
          GetBuilder<MainController>(
            builder: (controller) =>
                (controller.dataHistoryDatesTitles.isNotEmpty)
                    ? GestureDetector(
                        onTap: (() {
                          getDialogWidget(
                            context,
                            "are you want to Erase all data ?\nTo delete specific One swipe Right <-"
                                .tr,
                            () {
                              mainController.deleteAllHistory();
                              Navigator.of(context).pop(false);
                            },
                          );
                        }),
                        //////////////
                        child: const Padding(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Icon(
                            FontAwesomeIcons.solidTrashCan,
                            size: 20,
                          ),
                        ),
                      )
                    : const SizedBox(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: GetBuilder<MainController>(builder: (mainController) {
          switch (mainController.dataHistoryDatesTitles.isEmpty) {
            case true:
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                    angeryPersonWidget(context, 'Empty'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    CustomButton(
                        txt: "Let's Collect Order".tr,
                        onpressedFunc: () {
                          Get.to(() => const PeoplePage());
                        },
                        width: MediaQuery.of(context).size.width - 50),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const AddBannerWidget(),
                  ],
                ),
              );
            case false:
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ListView.separated(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mainController.dataHistoryDatesTitles.length,
                      itemBuilder: (context, index) => Center(
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.endToStart) {
                              return await getDialogWidget(
                                context,
                                "Are you sure ?".tr,
                                () {
                                  mainController.deleteHistoryKey(mainController
                                      .dataHistoryDatesTitles[index]['key']);
                                  Navigator.of(context).pop(false);
                                },
                              );
                            } else {
                              return false;
                            }
                          },
                          key: UniqueKey(),
                          background: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: const Offset(5, 2),
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 5,
                                    spreadRadius: 0.5)
                              ],
                              color: main2Color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              var historyDataKey = await mainController
                                  .dataHistoryDatesTitles[index]['key'];
                              await mainController.getCurrentOrderToHistory(
                                  historyDataKey.toString());
                              Get.to(() => SummeryPage(
                                    currentOrder: mainController.historyOrder,
                                    btnAvailable: false,
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width,
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
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      txt: mainController
                                                  .dataHistoryDatesTitles[index]
                                              ['title'] ??
                                          "Empty",
                                      color: mainColor,
                                      size: 22),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        txt:
                                            "${"Details".tr} : ${mainController.dataHistoryDatesTitles[index]['date']}",
                                        color: main2Color,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                    ),
                  ),
                  const AddBannerWidget(),
                ],
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        }),
      ),
    );
  }
}

/////////////////        Dialog Alert Widget       ////////////////////
Future<bool?> getDialogWidget(
    BuildContext context, String txtData, Function()? onPressedFunc) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm".tr),
        content: Text(txtData.tr),
        actions: <Widget>[
          TextButton(
              onPressed: onPressedFunc,
              child: Text(
                "DELETE".tr,
                style: const TextStyle(color: main2Color),
              )),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              "CANCEL".tr,
              style: const TextStyle(color: mainColor),
            ),
          ),
        ],
      );
    },
  );
}
