class HomeModel {
  late bool status;
  late HomeDataModel data;
  HomeModel.fromjson(Map<String,dynamic>json){
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel {
 List<BannersDataModel> BannersDataList = [];
 List<ProductsDataModel> ProductsDataList = [];

 HomeDataModel.fromjson(Map<String,dynamic>json){
   json['banners'].forEach((value) {
     BannersDataList.add(BannersDataModel.fromjson(value));
   });
   json['products'].forEach((value) {
     ProductsDataList.add(ProductsDataModel.fromjason(value));
   });
 }
}

class BannersDataModel {
  late int id;
  late String image;
  BannersDataModel.fromjson(Map<String,dynamic>json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductsDataModel {
  late int id;
  late String image;
  late String name;
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
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}