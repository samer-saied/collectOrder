import 'package:collect_order/models/product_model.dart';

class OrderDetailsModel {
  int? id;
  String? user;
  List<ProductModel>? items;
  late List<int> quntity;
  String? createedDate;

  OrderDetailsModel(
      {required this.id,
      required this.user,
      required this.items,
      required this.quntity,
      required this.createedDate});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    if (json['items'] != null) {
      var itemsList = <ProductModel>[];
      json['items'].forEach((v) {
        itemsList.add(ProductModel.fromJson(v));
      });
      items = itemsList;
    }
    if (json['quntity'] != null) {
      List<int> itemsList = [];
      json['quntity'].forEach((v) {
        itemsList.add(int.parse(v));
      });
      quntity = itemsList;
    }
    createedDate = json['createedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user'] = user;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    // ignore: unnecessary_null_comparison
    if (quntity != null) {
      data['quntity'] = quntity.map((v) => v.toString()).toList();
    }
    // data['total'] = total;
    return data;
  }

  getQuntityTotal() {
    int quntityTotal = 0;
    for (var i = 0; i < quntity.length; i++) {
      quntityTotal += quntity[i];
    }
    return quntityTotal;
  }

  double getMoneyTotal() {
    double moneyTotal = 0;
    if (items!.isEmpty) {
      return moneyTotal;
    } else {
      for (var i = 0; i < items!.length; i++) {
        moneyTotal += (double.parse(items![i].price) * quntity[i]);
      }
    }

    return moneyTotal;
  }
}
