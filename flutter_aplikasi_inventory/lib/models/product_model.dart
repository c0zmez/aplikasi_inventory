List<ProductModel> productsFromJson(dynamic str) =>
    List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));

class ProductModel {
  late String? id;
  late String? productName;
  late String? productType;
  late int? productAmount;
  late String? productImage;

  ProductModel({
    this.id,
    this.productName,
    this.productType,
    this.productAmount,
    this.productImage,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    productName = json['productName'];
    productType = json['productType'];
    productAmount = json['productAmount'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['productName'] = productName;
    _data['productType'] = productType;
    _data['productAmount'] = productAmount;
    _data['productImage'] = productImage;
    return _data;
  }
}
