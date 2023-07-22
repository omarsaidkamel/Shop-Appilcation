import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Model/CategoriesModel.dart';
import 'package:shop_app/Model/HomeModel.dart';
import 'package:shop_app/Model/favrotieModel.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/screens/CategoriesScreen.dart';
import 'package:shop_app/screens/FavoriteScreen.dart';
import 'package:shop_app/screens/HomeScreen.dart';
import 'package:shop_app/screens/MainScreen.dart';
import 'package:shop_app/screens/SettingScreen.dart';
import 'package:shop_app/tools/cubit/status.dart';

import 'package:shop_app/tools/Sharedpreferencesclass.dart';
class AppCubit extends Cubit<ShopStatus>{
  AppCubit() : super(IntiShopStatus());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentnavbar = 0;
  Map<int,bool>favlist = {};
  late HomeModel homeModel;
  bool homedone = false;
  bool categoriesdone = false;
  bool favoritedone = false;
  late CategoriesModel categoriesModel;
  late FavoriteModel favoriteModel;
  List<Widget> Screens = [
    home_screen(),
    categories_screen(),
    favorite_screen(),
    setting_screen(),
  ];
  void ChangeNavScreen(int s){
    currentnavbar = s;
    emit(ChangeNavScreenStatus());
  }
  void GetHomeData(String token){
    homedone = false;
    emit(GetHomeDataLoadingStatus());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value){
      homedone = true;
      homeModel = HomeModel.fromjson(value.data);
      homeModel.data.ProductsDataList.forEach((element) {
        favlist[element.id] = element.in_favorites;
      });
      emit(GetHomeDataSuccessStatus());
    }).catchError((e){
      print(e.toString());
      emit(GetHomeDataErrorStatus());
    });
  }
  void GetCategoriesData(){
    categoriesdone = false;
    emit(GetCategoriesDataLoadingStatus());
    DioHelper.getData(
      url: 'categories',
    ).then((value){
      categoriesdone = true;
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(GetCategoriesDataSuccessStatus());
    }).catchError((e){
      print(e.toString());
      emit(GetCategoriesDataErrorStatus());
    });
  }
  void GetFavoriteData(String token){
    favoritedone = false;
    emit(GetFavoriteReload());
    DioHelper.getData(
      url: 'favorites',
      token: token
    ).then((value){
      print(value);
      favoritedone = true;
      favoriteModel = FavoriteModel.fromjson(value.data);
      emit(GetFavoriteSuccessStatus());
    }).catchError((e){
      print(e.toString());
      emit(GetFavoriteErrorStatus());
    });
  }
  void AddRemoveFavorite(int id,String token,bool f){
    DioHelper.postData(
      url: 'favorites',
      token: token,
      data: {
        'product_id': id,
      },
    ).then((value){
      print(value);
      if(f) favlist[id] = !favlist[id]!;
      GetFavoriteData(sharedpreferencesshop.getData(key: 'token'));
      emit(AddRemoveFavoriteSuccessStatus());
    }).catchError((e){
      print(e.toString());
      emit(AddRemoveFavoriteErrorStatus());
    });
  }

}