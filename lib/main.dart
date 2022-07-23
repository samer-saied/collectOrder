import 'package:collect_order/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/appcolors.dart';
import 'core/local_string.dart';
import 'pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  MainController mainController = Get.put(MainController());
  await mainController.getSettings();
  runApp(MyApp(
    settingsData: mainController.selectedLang ?? 'English',
  ));
}

class MyApp extends StatelessWidget {
  final String settingsData;
  const MyApp({Key? key, required this.settingsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getLocal() {
      switch (settingsData) {
        case 'Arabic':
          return const Locale('ar', 'EG');
        case 'English':
          return const Locale('en', 'US');
        case 'Spnaish':
          return const Locale('es', 'ES');
        default:
          return const Locale('ar', 'EG');
      }
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: getLocal(),
      translations: LocaleString(),
      fallbackLocale: const Locale('en', 'US'),
      title: 'Collect Order',
      theme: ThemeData(
          primaryColor: mainColor,
          appBarTheme: const AppBarTheme(color: mainColor),
          buttonTheme: const ButtonThemeData(
            buttonColor: mainColor,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(mainColor),
          )),
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(backgroundColor: mainColor)),
      home: HomePage(),
    );
  }
}
