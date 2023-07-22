class FavoriteModel {
  late bool status;
  late FavoriteDataModel data;
  FavoriteModel.fromjson(Map<String,dynamic>json){
    status = json['status'];
    data = FavoriteDataModel.fromjson(json['data']);
  }
}

class FavoriteDataModel {
  List<ProductsDataModel> ProductsDataList = [];
  FavoriteDataModel.fromjson(Map<String,dynamic>json){
    json['data'].forEach((value) {
      ProductsDataList.add(ProductsDataModel.fromjason(value['product']));
    });
  }
}
class ProductsDataModel {
  late int id;
  late String image;
  late String name;
  late String description;
  late dynamic price;
  late dynamic discount;
  late dynamic old_price;
  late bool in_favorites;
  late bool in_cart;

  ProductsDataModel.fromjason(Map<String,dynamic>json){
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    old_price = json['old_price'];
    description = json['description'];
  }
}