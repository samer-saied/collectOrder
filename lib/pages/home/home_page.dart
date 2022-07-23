import 'package:collect_order/core/ads/ad_banner_widget.dart';
import 'package:collect_order/pages/home/history_page.dart';
import 'package:collect_order/pages/people/people_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';
import '../../core/app_drawer.dart';
import '../../core/appcolors.dart';
import '../../core/appwidgets.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  MainController mainController = Get.find<MainController>();

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: const MainDrawer(),
        appBar: AppBar(
          leading: GestureDetector(
              child: const Icon(FontAwesomeIcons.gear, size: 20),
              onTap: () {
                _key.currentState!.openDrawer(); //<-- SEE HERE
              }),
          title: CustomText(txt: "welcome".tr, color: whiteColor, size: 24),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(
                      children: [
                        Center(
                          child: Image(
                            width: MediaQuery.of(context).size.width * 0.5,
                            image: const AssetImage(
                                "assets/images/person-1_start.png"),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height / 4 < 125
                                ? 125
                                : MediaQuery.of(context).size.height / 4,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/images/bubble.png"),
                            )),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.07,
                              ),
                              child: CustomText(
                                txt: "Whatwant".tr,
                                size: 16,
                                color: mainColor,
                                alignCenter: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomButton(
                      txt: "collectOrder".tr,
                      onpressedFunc: () {
                        Get.to(() => const PeoplePage());
                      },
                      width: MediaQuery.of(context).size.width - 50),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomButton(
                      txt: "checkHistory".tr,
                      onpressedFunc: () {
                        Get.to(() => HistoryPage());
                      },
                      width: MediaQuery.of(context).size.width - 50),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const AddBannerWidget(),
                ],
              ),
            ),
          ),
        ));
  }
}
