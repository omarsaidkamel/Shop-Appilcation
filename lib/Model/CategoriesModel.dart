class CategoriesModel{
 bool status = true;
 late CategoriesData data;
 CategoriesModel.fromjson(Map<String,dynamic>M){
  status = M['status'];
  data = CategoriesData.fromjson(M['data']);
 }

}

class CategoriesData{
 int current_page = 0;
 List<Data> categoriesdata = [];
 CategoriesData.fromjson(Map<String,dynamic>M){
  current_page = M['current_page'];
  M['data'].forEach((value) {
   categoriesdata.add(Data.fromjson(value));
  });
 }
}

class Data{
 late int id;
 late String name;
 late String image;
 Data.fromjson(Map<String,dynamic>M){
  id = M['id'];
  name = M['name'];
  image = M['image'];
 }
}