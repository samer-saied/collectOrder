import 'package:collect_order/controller/main_controller.dart';
import 'package:collect_order/core/appcolors.dart';
import 'package:collect_order/core/appwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    void launchUrlFun() async {
      final Uri urlLink = Uri.parse('http://www.samersaied.me/');

      if (!await launchUrl(urlLink, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $urlLink';
      }
    }

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: mainColor,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImage(
                                width: 100,
                                height: MediaQuery.of(context).size.height / 8,
                                stringImage: "assets/images/people3person.png"),
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: CustomText(
                                  txt: "Collect Order",
                                  color: whiteColor,
                                  size: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Currency'.tr),
                      DropdownButton<String>(
                        value: mainController.selectedCurrency,
                        items: <String>['EGP', 'USD', 'RAY', 'DAR']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          mainController.putSettings({
                            'Currency': newValue,
                            'lang': mainController.selectedLang
                          });

                          setState(() {
                            mainController.selectedCurrency = newValue!;
                          });
                        },
                      )
                    ],
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Language'.tr),
                      DropdownButton<String>(
                        value: mainController.selectedLang,
                        items: <String>[
                          'Arabic',
                          'English',
                          'Spnaish',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          mainController.putSettings({
                            'lang': newValue,
                            'Currency': mainController.selectedCurrency
                          });
                          setState(() {
                            mainController.selectedLang = newValue!;
                            switch (newValue) {
                              case 'Arabic':
                                Get.updateLocale(const Locale('ar', 'EG'));

                                break;
                              case 'English':
                                Get.updateLocale(const Locale('en', 'US'));

                                break;
                              case 'Spnaish':
                                Get.updateLocale(const Locale('es', 'ES'));

                                break;

                              default:
                                Get.updateLocale(const Locale('en', 'US'));
                            }
                          });
                        },
                      )
                    ],
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => launchUrlFun(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text('Developed by'),
                Text('www.samersaied.me'),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
