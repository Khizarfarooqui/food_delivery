class BeveragesModel{
  String itemName = "";
  String beveragesImageUrl = "";
  double price = 0.0;

  BeveragesModel.emptyConstructor();

  BeveragesModel.addNewBeveragesItem({required this.price, required this.itemName, required this.beveragesImageUrl,});

  BeveragesModel.fromJson(Map<String ,dynamic> json){
    itemName = json["itemName"] ?? "";
    beveragesImageUrl = json["beveragesImageUrl"] ?? "";
    price = json["price"] ?? 0.0;
  }

  Map<String, dynamic> toJson(){
    return {
      "itemName" : itemName,
      "beveragesImageUrl" : beveragesImageUrl,
      "price" : price,
    };
  }

  @override
  String toString() {
    return 'BeveragesModel{itemName: $itemName, popularImageUrl: $beveragesImageUrl, price: $price,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BeveragesModel &&
              runtimeType == other.runtimeType &&
              itemName == other.itemName &&
              beveragesImageUrl == other.beveragesImageUrl &&
              price == other.price;

  @override
  int get hashCode =>
      itemName.hashCode ^
      beveragesImageUrl.hashCode ^
      price.hashCode;
}