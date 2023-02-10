class CartModel{
  String itemName = "";
  String popularImageUrl = "";
  double price = 0.0;

  CartModel.empty();

  CartModel.addNewItem({
    required this.itemName,
    required this.popularImageUrl,
    required this.price,
});

  CartModel.fromJson(Map<String, dynamic> json){
    itemName = json["itemName"] ?? "";
    popularImageUrl = json['popularImageUrl'] ?? "";
    price = json["price"] ?? 0.0;
  }

  Map<String, dynamic>toJson(){
    return {
      "itemName" : itemName,
      "price" : price,
      "popularImageUrl" : popularImageUrl,
    };
  }

  @override
  String toString() {
    return 'CartModel{itemName: $itemName, popularImageUrl: $popularImageUrl, price: $price}';
  }
}