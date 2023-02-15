class MainCourseModel{
  String itemName = "";
  String mainCourseImageUrl = "";
  double price = 0.0;

  MainCourseModel.emptyConstructor();

  MainCourseModel.addNewMainCourse({required this.price, required this.itemName, required this.mainCourseImageUrl,});

  MainCourseModel.fromJson(Map<String ,dynamic> json){
    itemName = json["itemName"] ?? "";
    mainCourseImageUrl = json["mainCourseImageUrl"] ?? "";
    price = double.parse("${json["price"] ?? 0.0}");
  }

  Map<String, dynamic> toJson(){
    return {
      "itemName" : itemName,
      "mainCourseImageUrl" : mainCourseImageUrl,
      "price" : price,
    };
  }

  @override
  String toString() {
    return 'MainCourseModel{itemName: $itemName, mainCourseImageUrl: $mainCourseImageUrl, price: $price,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MainCourseModel &&
              runtimeType == other.runtimeType &&
              itemName == other.itemName &&
              mainCourseImageUrl == other.mainCourseImageUrl &&
              price == other.price;

  @override
  int get hashCode =>
      itemName.hashCode ^
      mainCourseImageUrl.hashCode ^
      price.hashCode;
}