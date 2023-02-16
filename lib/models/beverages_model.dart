class BeveragesModel{
  String itemName = "";
  String imageUrl = "";
  double price = 0.0;

  BeveragesModel.emptyConstructor();

  BeveragesModel.addNewBeveragesItem({required this.price, required this.itemName, required this.imageUrl,});

  BeveragesModel.fromJson(Map<String ,dynamic> json){
    itemName = json["itemName"] ?? "";
    imageUrl = json["imageUrl"] ?? "";
    price = json["price"] ?? 0.0;
  }

  Map<String, dynamic> toJson(){
    return {
      "itemName" : itemName,
      "imageUrl" : imageUrl,
      "price" : price,
    };
  }

  @override
  String toString() {
    return 'BeveragesModel{itemName: $itemName, imageUrl: $imageUrl, price: $price,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BeveragesModel &&
              runtimeType == other.runtimeType &&
              itemName == other.itemName &&
              imageUrl == other.imageUrl &&
              price == other.price;

  @override
  int get hashCode =>
      itemName.hashCode ^
      imageUrl.hashCode ^
      price.hashCode;
}