import 'package:shared_preferences/shared_preferences.dart';


class sharedpreferencesshop{
  static late SharedPreferences prefs;
   static init() async{
     prefs = await SharedPreferences.getInstance();
   }
   static Future<bool?> saveData({
    required String key,
    required dynamic value,
})async{
     if(value is String) return await prefs.setString(key, value);
     if(value is bool) return await prefs.setBool(key, value);
     if(value is double) return await prefs.setDouble(key, value);
     return await prefs.setInt(key, value);
   }

  static dynamic getData({
    required String key,
  }){
    return prefs.get(key);
  }
  static dynamic removeData({
    required String key,
  }){
    return prefs.remove(key);
  }
}