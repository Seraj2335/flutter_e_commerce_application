class Model {
  String productName;
  String productImage;
  String price;
  String isPublished;
  Model(
      {required this.productName,
      required this.productImage,
      required this.isPublished,
      required this.price});
  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      price: json['price'] as String,
      isPublished: json['isPublished'] as String,
    );
  }
}
