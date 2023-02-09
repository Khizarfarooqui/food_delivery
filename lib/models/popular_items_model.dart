class PopularItemsModel{
  String itemName = "";
  String popularImageUrl = "";
  double price = 0.0;
  bool isInFavourite = false;

  PopularItemsModel.emptyConstructor();

  PopularItemsModel.addNewPopularItem({required this.price, required this.itemName, required this.popularImageUrl, required this.isInFavourite});

  PopularItemsModel.fromJson(Map<String ,dynamic> json){
    itemName = json["itemName"] ?? "";
    popularImageUrl = json["popularImageUrl"] ?? "";
    price = json["price"] ?? 0.0;
    isInFavourite = json["isInFavourite"] ?? false;
  }

  Map<String, dynamic> toJson(){
    return {
      "itemName" : itemName,
      "popularImageUrl" : popularImageUrl,
      "price" : price,
      "isInFavourite" : isInFavourite,
    };
  }

  @override
  String toString() {
    return 'PopularItemsModel{itemName: $itemName, popularImageUrl: $popularImageUrl, price: $price, isInFavourite: $isInFavourite}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PopularItemsModel &&
          runtimeType == other.runtimeType &&
          itemName == other.itemName &&
          popularImageUrl == other.popularImageUrl &&
          price == other.price &&
          isInFavourite == other.isInFavourite;

  @override
  int get hashCode =>
      itemName.hashCode ^
      popularImageUrl.hashCode ^
      price.hashCode ^
      isInFavourite.hashCode;
}