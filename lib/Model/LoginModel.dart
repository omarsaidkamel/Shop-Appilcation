class LoginModel{
  late bool status;
  late String message;
  DataUser? dataUser;

  LoginModel.fromJason(Map<String,dynamic>data){
    status = data['status'];
    message = data['message'];
    if (data['data'] != null) {
      dataUser = DataUser.fromJason(data['data']);
    }
  }
}

class DataUser {
  late String name;
  late String phone;
  late String email;
  late String image;
  late String token;
  late int points;
  late int credit;
  late int id;

  DataUser.fromJason(Map<String,dynamic>data){
        name = data['name'];
        phone = data['phone'];
        email = data['email'];
        image = data['image'];
        token = data['token'];
        credit = data['credit'];
        credit = data['credit'];
        id = data['id'];
  }
}