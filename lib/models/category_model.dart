class CategoryModel{

  String categoryName = "";
  String categoryImageUrl = "";

  CategoryModel.empty();

  CategoryModel.addNewCategory({required this.categoryName, required this.categoryImageUrl,});

  CategoryModel.fromJson(Map<String,dynamic> json){
    categoryName = json["categoryName"] ?? "";
    categoryImageUrl = json["categoryImageUrl"] ?? "";
  }

  Map<String,dynamic> toJson(){
    return {
      "categoryName" : categoryName,
      "categoryImageUrl" : categoryImageUrl,
    };
  }

  @override
  String toString() {
    return 'CategoryModel{categoryName: $categoryName, categoryImageUrl: $categoryImageUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          categoryName == other.categoryName &&
          categoryImageUrl == other.categoryImageUrl;

  @override
  int get hashCode => categoryName.hashCode ^ categoryImageUrl.hashCode;
}