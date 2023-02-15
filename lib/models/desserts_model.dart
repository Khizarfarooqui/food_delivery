class DessertModel{
  String itemName = "";
  String dessertImageUrl = "";
  double price = 0.0;

  DessertModel.emptyConstructor();

  DessertModel.addNewDessertItem({required this.price, required this.itemName, required this.dessertImageUrl,});

  DessertModel.fromJson(Map<String ,dynamic> json){
    itemName = json["itemName"] ?? "";
    dessertImageUrl = json["dessertImageUrl"] ?? "";
    price = json["price"] ?? 0.0;
  }

  Map<String, dynamic> toJson(){
    return {
      "itemName" : itemName,
      "dessertImageUrl" : dessertImageUrl,
      "price" : price,
    };
  }

  @override
  String toString() {
    return 'DessertModel{itemName: $itemName, dessertImageUrl: $dessertImageUrl, price: $price,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DessertModel &&
              runtimeType == other.runtimeType &&
              itemName == other.itemName &&
              dessertImageUrl == other.dessertImageUrl &&
              price == other.price;

  @override
  int get hashCode =>
      itemName.hashCode ^
      dessertImageUrl.hashCode ^
      price.hashCode;
}