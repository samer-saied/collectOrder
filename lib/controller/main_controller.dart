import 'dart:convert';

import 'package:collect_order/core/storage_app.dart';
import 'package:collect_order/models/order_model.dart';
import 'package:collect_order/models/product_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/order_details_model.dart';

class MainController extends GetxController {
  StorageApp storage = StorageApp();
  var peopleNumber = 1.obs;
  var people = [];
  RxList<ProductModel> products = <ProductModel>[].obs;
  List dataHistoryDatesTitles = [];
  List<OrderDetailsModel> ordersDetails = <OrderDetailsModel>[].obs;
  late OrderModel currentOrder;
  late OrderModel historyOrder;
  double orderFees = 0.0;
  List<String> historyKeys = [];
  List<dynamic> historyTitles = [];
  bool isLocked = true;
  ////
  ///
  ///
  ///     APPLICATION SETTINGS
  ///
  ///
  String? selectedLang;
  String? selectedCurrency;
  ///////
  ///
  ///
  ///
  ///
  ///
  ///
  changeIsLocked() {
    isLocked = !isLocked;
    update();
  }

  changeFeesValue(String newData) {
    // print("=========change===========");
    orderFees = double.parse(newData);
    currentOrder.fees = orderFees.toString();
    // print(currentOrder.fees);
    update();
  }

  resetData() {
    orderFees = 0.0;
    // isLocked = true;
    peopleNumber = 1.obs;
    people = [];
  }

  getCurrentDate() {
    final nowDate = DateTime.now();
    return DateFormat('dd-MM-yyy hh:mm:ss').format(nowDate);
  }

  incrementPeople() {
    return peopleNumber++;
  }

  decrementPeople() {
    if (peopleNumber.value <= 1) {
      return;
    } else {
      return peopleNumber--;
    }
  }

  insertToPeople({required int index, required String value}) {
    if (people.length == peopleNumber.value) {
      people[index] = value;
    } else {
      people.clear();
      fillListWithTempData(
          tempList: people, listLength: peopleNumber.value, listTitle: "User");
      people[index] = (value);
    }
  }

  insertToProducts({
    required int index,
    required String productTitle,
    required String productPrice,
  }) {
    ProductModel product = ProductModel(productTitle, productPrice.toString());
    products.add(product);
  }

  removeToProducts({required int index}) {
    products.removeAt(index);
  }

  fillListWithTempData(
      {required List tempList,
      required int listLength,
      required String listTitle}) {
    tempList.clear();
    for (var i = 0; i < listLength; i++) {
      tempList.add("$listTitle ${i + 1}");
    }
  }

  int getPicNumber(int indexPic) {
    int lessNumber = indexPic;
    if (indexPic > 5) {
      lessNumber = indexPic - 5;
      getPicNumber(lessNumber);
    } else {
      return lessNumber;
    }
    return lessNumber;
  }

////////////  ADD OR REMOVE Quntity //////////////
  incrementQuntity(int indexOrder, int index) {
    ordersDetails[indexOrder].quntity[index] += 1;
    update();
  }

  decrementQuntity(int indexOrder, int index) {
    if (ordersDetails[indexOrder].quntity[index] <= 0) {
      ordersDetails[indexOrder].quntity[index] = 0;
      update();
    } else {
      ordersDetails[indexOrder].quntity[index] -= 1;
      update();
    }
  }

  createOrderList() async {
    ordersDetails = <OrderDetailsModel>[];
    for (var i = 0; i < peopleNumber.value; i++) {
      var quntityList = List<int>.generate(products.length, (i) => 0);
      ordersDetails.add(OrderDetailsModel(
          id: i,
          user: people[i],
          items: products,
          quntity: quntityList,
          createedDate: getCurrentDate()));
    }
    int total = await storage.getTotalOfHistoryOrders();
    currentOrder = OrderModel(
        id: DateTime.now().toString(),
        title: "${"Order".tr} $total",
        details: ordersDetails,
        createedDate: getCurrentDate(),
        fees: orderFees.toString(),
        status: "done");
  }

  editOrderList(int index, List<int> quntity) {
    ordersDetails[index].quntity = quntity;
  }

  getProductNumbers(OrderModel order, int productIndex) {
    int productsNumber = 0;
    for (var i = 0; i < order.details.length; i++) {
      productsNumber += order.details[i].quntity[productIndex];
    }
    return productsNumber;
  }

  ///
  ///
  ///
  ///     Settings       /////////
  getSettings() async {
    var data = await storage.getSettingDate();
    selectedLang = data['lang'];
    selectedCurrency = data['currency'];
    return data;
  }

  putSettings(Map<String, dynamic> newData) async {
    await storage.putSettingData(newData);
  }

  ///
  ///
  ///
  ///     Storage       /////////
  getHistoryDatesTitles() async {
    dataHistoryDatesTitles = await storage.getAllDatesTitles();
    update();
  }

  saveCurrentOrderToHistory() {
    String josnData = json.encode(currentOrder);
    storage.putData(getCurrentDate(), {"data": josnData});
  }

  getCurrentOrderToHistory(String orderKey) async {
    try {
      String currentOrder = await storage.getOneDate(orderKey);
      var josnData = json.decode(currentOrder);
      historyOrder = OrderModel.fromJson(josnData);
      // print(historyOrder.toJson());
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  deleteHistoryKey(String key) async {
    try {
      await storage.clearDataFromStorage(key);
      await getHistoryDatesTitles();
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  deleteAllHistory() async {
    try {
      await storage.clearALLDataFromStorage();
      await getHistoryDatesTitles();
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
