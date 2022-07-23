import 'package:collect_order/models/order_details_model.dart';

class OrderModel {
  late String id;
  late String title;
  late List<OrderDetailsModel> details;
  String? status;
  String? total;
  String? fees;
  late String createedDate;

  OrderModel({
    required this.id,
    required this.title,
    required this.details,
    required this.createedDate,
    required this.status,
    this.total = "0",
    this.fees = "0",
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? "Order";

    if (json['details'] != null) {
      var detailsList = <OrderDetailsModel>[];
      json['details'].forEach((v) {
        detailsList.add(OrderDetailsModel.fromJson(v));
      });
      details = detailsList;
    }
    createedDate = json['createedDate'];
    status = json['status'];
    fees = json['fees'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['details'] = details;
    data['createedDate'] = createedDate;
    data['status'] = status;
    data['fees'] = fees;
    return data;
  }

  double getAllTotal() {
    double total = 0;
    for (var element in details) {
      total += element.getMoneyTotal();
    }
    return total;
  }

  double getAllTotalFees() {
    double totalFees = 0;
    double total = getAllTotal();
    totalFees = total + double.parse(fees ?? "0");
    return totalFees;
  }
}
