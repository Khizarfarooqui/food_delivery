
class MenuModel {

  String menuName = "";
  String menuImageUrl = "";
  double price = 0.0;

  MenuModel.empty();

  MenuModel.addNewModel({required this.menuName, required this.menuImageUrl, required this.price});

  MenuModel.fromJson(Map<String, dynamic> json){
    menuName = json["menuName"] ?? "";
    menuImageUrl = json["menuImageUrl"] ?? "";
    price = json["price"] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
    "menuName" : menuName,
    "menuImageUrl" : menuImageUrl,
      "price" : price,
  };
  }

  @override
  String toString() {
    return 'MenuModel{menuName: $menuName, menuImageUrl: $menuImageUrl, price: $price}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuModel &&
          runtimeType == other.runtimeType &&
          menuName == other.menuName &&
          menuImageUrl == other.menuImageUrl &&
          price == other.price;

  @override
  int get hashCode =>
      menuName.hashCode ^ menuImageUrl.hashCode ^ price.hashCode;
}
