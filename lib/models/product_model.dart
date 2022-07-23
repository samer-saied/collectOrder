class ProductModel {
  final String title;
  final String price;

  ProductModel(
    this.title,
    this.price,
  );

  ProductModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        price = json['price'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['price'] = price;
    return data;
  }
}
