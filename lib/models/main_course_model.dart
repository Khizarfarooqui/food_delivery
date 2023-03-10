class MainCourseModel{
  String itemName = "";
  String imageUrl = "";
  double price = 0.0;

  MainCourseModel.emptyConstructor();

  MainCourseModel.addNewMainCourse({required this.price, required this.itemName, required this.imageUrl,});

  MainCourseModel.fromJson(Map<String ,dynamic> json){
    itemName = json["itemName"] ?? "";
    imageUrl = json["mainCourseImageUrl"] ?? "";
    price = double.parse("${json["price"] ?? 0.0}");
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
    return 'MainCourseModel{itemName: $itemName, imageUrl: $imageUrl, price: $price,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MainCourseModel &&
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