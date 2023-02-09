class FavouritesModel{

  String itemName = "";
  String popularImageUrl = "";
  double price = 0.0;
  String isFavourite = "";

  FavouritesModel.empty();

  FavouritesModel.addNewFavourite({
    required this.isFavourite,
    required this.price,
    required this.itemName,
    required this.popularImageUrl,
  });

  FavouritesModel.fromJson(Map<String ,dynamic> json){
    isFavourite = "${json["isFavourite"] ?? ""}";
    itemName = json["itemName"] ?? "";
    popularImageUrl = json["popularImageUrl"] ?? "";
    price = json["price"] ?? 0.0;
  }

  Map<String ,dynamic>toJson(){
    return {
      "isFavourite" : isFavourite=="true",
      "itemName" : itemName,
      "popularImageUrl" : popularImageUrl,
      "price" : price,
    };
  }

  @override
  String toString() {
    return 'FavouritesModel{itemName: $itemName, popularImageUrl: $popularImageUrl, price: $price, isFavourite: $isFavourite}';
  }
}
