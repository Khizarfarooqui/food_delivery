
class MyMenuModel{
  String imageUrl = "";
  String itemName = "";
  double price = 0.0;

  MyMenuModel.emptyConstructor();

  MyMenuModel.addNewMenuModel({required this.price, required this.itemName, required this.imageUrl,});

  MyMenuModel.fromJson(Map<String ,dynamic> json){
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
    return 'MyMenuModel{itemName: $itemName, imageUrl: $imageUrl, price: $price,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MyMenuModel &&
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